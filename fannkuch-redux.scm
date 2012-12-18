(define (rotate ls)
  (if (null? ls)
      ls
      (append (cdr ls) (list (car ls)))))

(define (permutations ls)
  (let ((len (length ls)))
    (if (= 1 len)
        (list ls)
        (let r ((result '()) (ls1 ls) (rotate-times len))
          (if (= 0 rotate-times)
              result
              (r (append result
                         (map (lambda (x) (cons (car ls1) x))
                                      (permutations (cdr ls1))))
                 (rotate ls1) (- rotate-times 1)))))))

(define (permutation2 ls) ;generator style
  (let ((len (length ls)))
    (if (= 1 len)
        (list ls)
        (let r ((result '()) (ls1 ls) (rotate-times len))
          (if (= 0 rotate-times)
              result
              (r (append result
                         (map (lambda (x) (cons (car ls1) x))
                                      (permutations (cdr ls1))))
                 (rotate ls1) (- rotate-times 1)))))))

(define (m1 v k)
  (lambda (x) (k (cons v x))))


(define (reverse-by-first-elem ls)
  (let ((n (car ls)))
    (append (reverse (list-head ls n))
            (list-tail ls n))))

(define (max-flips ls)
  (let r ((times 0) (nls ls))
    (let ((e1 (car nls)))
      (if (= 1 e1)
          times
          (r (+ 1 times) (reverse-by-first-elem nls))))))

;; (define q '(1 2 3 4 5 6 7 8 9 10 11 12))

;; (display (apply max (map max-flips (permutations ))))
;; (newline)


;; (max-flips '(7 6 5 4 3 2 1))

(define (process p)
  (set! pile (cons (max-flips p) pile)))

(define (incred-permutation proc cur rest)
  (if (null? rest)
      (proc (max-flips cur))
       (for-each
        (lambda (x) (incred-permutation
                     proc
                     (cons x cur)
                     (remove (lambda (y) (= x y)) rest)))
        rest)))

(define (incred-permutation2 proc cur rest)
  (if (null? rest)
      (proc (max-flips cur))
       (for-each2
        (lambda (M R) (incred-permutation2
                       proc
                       (cons M cur)
                       R))
        rest)))

(define (for-each2 P L)
  (let R ((mid (car L))
          (left '())
          (right (cdr L)))
    (P mid (append (reverse left) right))
    (if (not (null? right))
        (R (car right)
           (cons mid left)
           (cdr right)))))

(define (for-each3 P L)
  q

;; (for-each2 (lambda (M R)
;;         (format #t "middle is: ~a\n" M)
;;         (format #t "rest is: ~a\n" R))
;;       '(1 2 3 4))

;; (use-modules (statprof))

;; (statprof-reset 0 50000 #t)
;; (statprof-start)
(begin
  (let* ((max 0)
         (f (lambda (x) (if (> x max)
                         (set! max x)))))
    ;; (use-modules (srfi srfi-1))
    ;; (incred-permutation f '() '(1 2 3 4 5 6 7 8))
    ;; (incred-permutation2 f '() '(1 2 3 4 5 6 7 8 9 10 11 12))
    (incred-permutation2 f '() '(1 2 3 4 5 6 7 8 9 10 11 12))
    (display max)
    (newline)))
;; (statprof-stop)
;; (statprof-display)

;; (define q (make-bytevector 7))

(define (test . x)
  (format #t "~a" x))

(test 1 2 3 4)
