(define (qsort x)
  (if (null? x)
      '()
      (let* ((y (car x))
             (s1 (filter (lambda (a) (<= a y)) (cdr x)))
             (s2 (filter (lambda (a) (> a y)) (cdr x))))
        (append (qsort s1) (list y) (qsort s2)))))

(define (reverse2 x)
  (let loop ((out '()) (rem x))
    (if (null? rem)
        out
        (loop (cons (car rem) out) (cdr rem)))))

(define (qsort2 x)
  (if (null? x)
      '()
      (let ((piv (car x)))
        (let LM ((s1 '()) (s2 '()) (rem (cdr x)))
          (if (null? rem)
              (let LA ((qs1 (reverse2 (qsort2 s1)))
                       (qs2 (cons piv (qsort2 s2))))
                (if (null? qs1)
                    qs2
                    (LA (cdr qs1) (cons (car qs1) qs2))))
              (let ((remh (car rem)) (remt (cdr rem)))
                (if (< piv remh)
                    (LM s1 (cons remh s2) remt)
                    (LM (cons remh s1) s2 remt))))))))

(define target-list
  (let loop ((ls '()) (i 1000000))
    (if (= i 0)
        ls
        (loop (cons (random 1000000) ls) (1- i)))))

(use-modules (statprof)
             (ice-9 format))

(statprof-reset 0 50000 #t)
(statprof-start)
(qsort target-list)
(statprof-stop)

(format #t "Time for qsort: ~a\n" (statprof-accumulated-time))

(statprof-reset 0 50000 #t)
(statprof-start)
(qsort2 target-list)
(statprof-stop)

(format #t "Time for qsort2: ~a\n" (statprof-accumulated-time))
