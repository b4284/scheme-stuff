(define a)

;; entering a barrier
(with-continuation-barrier
 (lambda ()
   (call/cc
    (lambda (k)
      (set! a k)
      1
      ))))

(a) ;exception!


;;;; leaving a barrier
(call/cc
 (lambda (k)
   (set! a k)
   1
   ))

(with-continuation-barrier
  (lambda () (a))) ;exception!
