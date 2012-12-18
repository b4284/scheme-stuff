(define (replicate obj times)
  (let r ((target '()) (rt times))
    (if (= 0 rt)
        target
        (r (cons obj target) (- rt 1)))))

(replicate "a" 100)

(define (qsort x)
  (if (null? x)
      '()
      (let* ((piv (car x))
             (smaller (qsort (filter (lambda (y) (< y piv)) (cdr x))))
             (larger (qsort (filter (lambda (y) (>= y piv)) (cdr x)))))
        (append smaller (cons piv larger)))))

(qsort '(1 1234 34 12 412 4312 431 234 1234 12))


(filter (lambda (x) (> x 5)) '(2 4 6 8 10))
