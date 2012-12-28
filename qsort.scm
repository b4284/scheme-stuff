;; qsort: naive

(define (qsort x)
  (if (null? x)
      '()
      (let* ((y (car x))
             (s1 (filter (lambda (a) (<= a y)) (cdr x)))
             (s2 (filter (lambda (a) (> a y)) (cdr x))))
        (append (qsort s1) (list y) (qsort s2)))))

;; qsort2: using only car, cdr and cons to construct the result

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

;; qsort3: using vectors and in-place swapping

(define (vector-ref-swap v i1 i2)
  (if (not (= i1 i2))
      (let ((vi1 (vector-ref v i1)))
        (vector-set! v i1 (vector-ref v i2))
        (vector-set! v i2 vi1))))

(define (qsort3v v begi endi)
  (if (< begi endi)
      (let ((piv (vector-ref v begi)))
        (let loop ((pivi begi) (pi (+ 1 begi)))
          (if (> pi endi)
              (begin
                (if (> pivi begi)
                    (qsort3v v begi (- pivi 1)))
                (if (> endi pivi)
                    (qsort3v v (+ pivi 1) endi)))
              (let ((vpi (vector-ref v pi)))
                (if (< vpi piv)
                    (begin
                      (if (= (+ 1 pivi) pi)
                          (vector-ref-swap v pivi pi)
                          (begin
                            (vector-ref-swap v pivi (+ 1 pivi))
                            (vector-ref-swap v pi pivi)))
                      (loop (+ 1 pivi) (+ 1 pi)))
                    (loop pivi (+ 1 pi)))))))))

(define (qsort3 x)
  (let ((rv (list->vector x)))
    (qsort3v rv 0 (- (length x) 1))
    (vector->list rv)))

;; start-program

(define target-list
  (let loop ((ls '()) (i 1000000))
    (if (= i 0)
        ls
        (loop (cons (random 1000000) ls) (1- i)))))

(use-modules (statprof)
             (ice-9 format))

(statprof-reset 0 50000 #t)
(statprof-start)
;(qsort target-list)
(statprof-stop)

(format #t "Time for qsort: ~a\n" (statprof-accumulated-time))

(statprof-reset 0 50000 #t)
(statprof-start)
;(qsort2 target-list)
(statprof-stop)

(format #t "Time for qsort2: ~a\n" (statprof-accumulated-time))

(statprof-reset 0 50000 #t)
(statprof-start)
(qsort3 target-list)
(statprof-stop)
(statprof-display)

(format #t "Time for qsort3: ~a\n" (statprof-accumulated-time))

(display (qsort3 '(3 2 1 5 4)))
