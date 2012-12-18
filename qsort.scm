(define (qsort x)
  (if (null? x)
      '()
      (let* ((y (car x))
             (s1 (filter (lambda (a) (<= a y)) (cdr x)))
             (s2 (filter (lambda (a) (> a y)) (cdr x))))
        (append (qsort s1) (list y) (qsort s2)))))

(define (qsort2 x)
  (let ((piv (car x)))
    (let LM ((s1 '()) (s2 '()) (rem (cdr x)))
      (if (null? rem)
          (qsort2


(qsort '(5 4 3 2 1))
