(define (k . a)
  (k2 k1 3 '() a))

(define (k2 rf ng prv arg)
  (let ((al (length arg)))
    (if (= al ng)
        (apply rf (append prv arg))
        (if (< al ng)
            (lambda (. x)
              (k2 rf (- ng al) (append prv arg) x))
            (error "too many arguments")))))

(define (k1 a b c)
    (* a b c))

;; ----------------------------------------

(define r1 (k 1))   ;; returns a lambda needs 2
(define r2 (r1 2))  ;; returns a lambda needs 1
(r2 3)              ;; returns 6

(define r3 (k 1 2)) ;; returns a lambda needs 1
(r3 3)              ;; returns 6

(k 1 2 3)           ;; returns 6 right away

(r2 3 4 5)
(r3 3 4)
(k 1 2 3 4)         ;; above 3 are all errors

;; ----------------------------------------
;; pitfall: need to know the target function arity, any ideas?
