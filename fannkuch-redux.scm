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

(define q (make-bytevector 7))
