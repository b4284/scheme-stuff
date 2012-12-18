(use-modules (ice-9 rdelim))


;; i generated my first "common" column file with `sort -u'

(define common-all
  (let ((common-file (open-input-file "/tmp/common")))
    (let q ((line (read-line common-file)) (lines '()))
      (if (eof-object? line)
          (reverse lines)
          (q (read-line common-file) (cons line lines))))))

(define 100-list
  (map (lambda (x) (string-append "/tmp/" x "100"))
       '("lh" "mm" "md" "mo" "sw" "mc" "kc")))

(define (process-1 file-path)
  (let ((new-file-path (string-append file-path "-after")))
    (let ((iport (open-input-file file-path))
          (oport (open-output-file new-file-path)))
      (let f ((common-rest common-all) (input-line (read-line iport)))
        (if (null? common-rest)
            (begin
              (close-port iport)
              (close-port oport)
              (display (string-append "finished: " new-file-path))
              (newline))
            (let* ((common-line (car common-rest))
                   (str-eq? (and
                             (not (eof-object? input-line))
                             (string=? common-line input-line))))
              (write-line (if str-eq?
                              (string-append common-line ",")
                              "null,")
                          oport)
              (f (cdr common-rest)
                 (if str-eq?
                     (read-line iport)
                     input-line))))))))

(map process-1 100-list)
