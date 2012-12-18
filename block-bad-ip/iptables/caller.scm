(define-module (iptables caller)
  #:use-module (ice-9 popen)
  #:use-module (ice-9 rdelim)
  #:export (iptables-chain))

;; private

(define (table-raw-strings table)
  (let ((port (open-input-pipe
               (string-append "iptables-save -t " table))))
    (let read-loop ((line (read-line port))
                    (r '()))
      (if (eof-object? line)
          (begin
            (close-port port)
            (reverse! r))
          (read-loop (read-line port) (cons line r))))))


(define (string->ipv4 x)
  (let* ((slashi (string-index x #\/))
         (ip (if slashi (substring x 0 slashi) x))
         (cidr (if slashi
                   (string->number (substring x (1+ slashi)))
                   32)))
    (let caloop ((start 0) (sum 0) (shift 24))
      (if (< shift 0)
          (list (cons 'ip-string ip) (cons 'ip-number sum)
                (cons 'ip-cidr cidr) (cons 'host? (= 32 cidr)))
          (let* ((end (string-index ip #\. (1+ start)))
                 (part (if end
                           (substring ip start end)
                           (substring ip start))))
            (caloop (if end (1+ end) 0)
                    (+ sum (ash (string->number part) shift))
                    (- shift 8)))))))


(define paired-options
  (list '("--state" . ())
        '("--mac-source" . ())
        (cons "--dport" (list (cons 'value-transform-f string->number)))
        '("-A" . ((sym . chain-name)))
        '("-j" . ((sym . target)))
        '("-m" . ((sym . match-name)))
        '("-i" . ((sym . in-dev)))
        (cons "-s" (list (cons 'value-transform-f string->ipv4)
                         (cons 'sym 'source)))
        '("-p" . ((sym . protocol)))))


(define (paired-option name)
  (let ((q (assoc name paired-options)))
    (if (not q)
        #f
        (let ((q1 (assq-ref q 'sym)) (q2 (assq-ref q 'value-transform-f)))
          (let ((q3 (if q1 q1 (string->symbol (substring name 2))))
                (q4 (if q2 q2 (lambda (x) x))))
            (list (cons 'sym q3)
                  (cons 'value-transform-f q4)))))))


; -- procedure+: parse-rule-string STRING TABLE-STRING
;       "rnva" stands for read-next-value-as, pass in an extra function
;       to convert the value.


(define (parse-rule-string str table)
  (let parse-loop ((ctx '())
                   (tokens (string-split str #\ ))
                   (r '()))
    (if (null? tokens)
        r
        (let ((tt (car tokens))
              (rt (cdr tokens)))
          (if (null? ctx)
              (cond
               ((paired-option tt)
                (parse-loop (cons 'rnva (paired-option tt)) rt r))
               (else
                ;; ignore this token if i don't know it
                (parse-loop ctx rt r)))
              (cond
               ((eq? (car ctx) 'rnva)
                (parse-loop '() rt
                            (cons (cons (assq-ref ctx 'sym)
                                  ((assq-ref ctx 'value-transform-f) tt)) r)))
               (else
                ;; ignore here too
                (parse-loop '() rt r))))))))


;; public

(define (iptables-chain chain . table)
  "(iptables-chain-raw CHAIN [TABLE])

CHAIN and TABLE are both strings. If TABLE is left empty, it is \"filter\"."
  (let ((table (if (> (length table) 0)
                   (car table)
                   "filter")))
    (map (lambda (x)
           (parse-rule-string x table))
         (filter! (lambda (x) (string-prefix? (string-append "-A " chain) x))
                  (table-raw-strings table)))))
