(define (bf-dptr-forward data dptr)


(define bf-instructions
  (list
   (cons (">" . (lambda (data dptr) 'a)))))

(define (bf program-string)
  ;; (let ((matching-brackets (bf-scan-bracket program-string)))
    (let run-loop
        ((data (make-vector 3000 0))
         (data-pointer 0)
         (next-instruction-i 0))
      (if (< next-instruction-i (string-length program-string))
          (let ((next-instruction
                 (string-ref program-string next-instruction-i)))
            (case next-instruction
              ((#\>)
               (run-loop data (1+ data-pointer) (1+ next-instruction-i)))
              ((#\<)
               (run-loop data (1- data-pointer) (1+ next-instruction-i)))
              ((#\+)
               (vector-set! data data-pointer
                            (1+ (vector-ref data data-pointer)))
               (run-loop data data-pointer (1+ next-instruction-i)))
              ((#\-)
               (vector-set! data data-pointer
                            (1- (vector-ref data data-pointer)))
               (run-loop data data-pointer (1+ next-instruction-i)))
              ((#\.)
               (display (vector-ref data data-pointer))
               (run-loop data data-pointer (1+ next-instruction-i)))
              ((#\,)
               (vector-set! data data-pointer
                            (char->integer (read-char)))
               (run-loop data data-pointer (1+ next-instruction-i)))
              )))))

(bf ",.")
