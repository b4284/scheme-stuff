;; TWENTY CHALLENGES FOR GREAT JUSTICE
;; ===================================

;; by quad




;; CHALLENGE 1

;; Define a macro THUNK which will wrap the body of the macro inside a lambda. That
;; is, define

;; (THUNK
;;   <body>)

;; so that we get

;; (lambda () <body>)


;; CHALLENGE 2

; Quadrescence:
; First, tell me why this can't be a function.
; Then implement it as a macro. --> A procedure called
; SET-IF! such that (set-if! pred sym val) sets the value of SYM to VAL
; only if PRED is true. Otherwise, it does nothing.
; (or if you want, otherwise, it just gives back NIL)

(define-syntax set-if!
  (syntax-rules ()
    ((_ pred sym val) (if pred
                          (set! sym val)))))

(macroexpand '(set-if! #f a 5))

(void)

;; CHALLENGE 3

; Quadrescence | qu1j0t3, EXERCISE: Write a version of LETREC which
;                allows one to use DEFINE syntax.
;                I think that syntax is more consistent with
;                general scheme syntax anyway. It's a little baroque
;                and definitely not "minimal" but neither is being able
;                to do (define (f x) ...)
;                when (define f (lambda (x) ...)) works fine
; Example:
;   (define (example x)
;     (with-definitions
;      ((define (is-even? x) (zero? (remainder x 2)))
;       (define rofl "rolling on the floor laughing"))
;      (if (is-even? x)
;          (display rofl)
;          (display ":("))))

(define-syntax with-definitions
  (syntax-rules () ())

(syntax->datum (syntax (foo bar baz)))


;; CHALLENGE 4

; Qworkescence | Similar in spirit to the counting change problem,
;                write a function to compute the "partitions of an integer".
;                A partition of N is some sum of smaller numbers that add to N.
;                So the partitions of 4 are (4) (3 1) (2 2) (2 1 1) (1 1 1 1)


;; CHALLENGE 5

; Quadrescence | CHALLENGE: replicate SML's reference type in scheme
;              | (define a (ref 9))
;              | (set-ref! a 8)
;              | (val a)
;              | ==> 8
;              | you can use "deref" instead of "val"


;; CHALLENGE 6

; Quadrescence | CHALLENGE: write bogosort


;; CHALLENGE 7

; Quadrescence | replicate the behavior of ye olde lisp's SETQ,
;                which is like SET! but allows several pairs of idents and vals
;                e.g., (setq x 1 y 2 z 3)
;                x is set to 1, y to 2, z to 3


;; CHALLENGE 8

; @Quadrescence | CHALLENGE: Make a macro (define* (f args) body)
;                 which defines f to be memoized: when you call f with
;                 arguments x, it'll save the value of the result
;                 so next time around, it just looks up the result.
;                 Extra credit: Do it without polluting the namespace
;                 (except w/ the function name of course)


;; CHALLENGE 9

; In challenge #8, you wrote a memoizing
; DEFINE macro called DEFINE*. However,
; this can be awkward and even inefficient
; when we have a COND or CASE. Consider:

; (define* (fib n)
;   (cond ((= n 0) 0)
;         ((= n 1) 1)
;         (else (+ (fib (- n 1))
;                  (fib (- n 2))))))

; Each time we compute a yet-uncomputed
; fibonacci, we have to check if it's 0
; first, then 1, then we can procede to
; compute.

; In this challenge, we want to be allowed
; to define constant cases which add to
; the hash table immediately. Let's call
; this definition procedure DEF.

; Example:

; (def fib
;   (0) => 0
;   (1) => 1
;   (n) => (+ (fib (- n 1))
;             (fib (- n 2))))

; This will create a function FIB which will
; have zero and one memoized, and allow for
; the general case. When we do call the general
; case for an unmemoized function, we no longer
; have to crawl the COND, because there is none.
; So we save comparisons each time it's called.

; For multi-argument functions, it would be illegal to have (4 b c) => ...
; for example.
; you can safely assume the last case will be the variable case


;; CHALLENGE 10

; @Quadrescence | qu1j0t3: this one isn't tough, but it's an important
; demonstration. Write a macro "with-degrees"
; which causes all trig functions (sin cos tan) to use degrees
; and not radians. Therefore if there is a
; (sin x), it should be changed to (sin (* pi (/ 180) x)),
; where pi=3.14159265358979
; (with-degrees (+ (sin 30) (sin 90))) should give 1.5


;; CHALLENGE 11

; Quadrescence | as an exercise, you should implement a C-style FOR loop:
;                (for ((<var> <init>) <condition> <post-loop-thing>) <body>)
;                without using DO
;                and <var>'s scope should be limited to FOR
;                example:  (for ((i 0)
;                                (< i 10)
;                                (set! i (+ 1 i)))
;                            (display i)
;                            (newline))
;                which would print 0 thru 9
;                UNLIKE C, i's scope is limited
; Quadrescence | Now extend FOR so you can do (for (<VAR> <LST>) ...)
;                and it will iterate over the list
;                (this is equivalent to CL's DOLIST macro)


;; CHALLENGE 12

// Quadrescence | write a program which takes a sentence (you can assume no punctuation)
//                and mixes the middle letters of the words randomly, and writes it to stdout
//                based on that classic thing where you can read text even if the middle letters
//                are scrambled, but the first and last remain the same


;; CHALLENGE 13

; Quad:
; I think you should create the macro you suggested. In Common Lisp,
; this macro is DESTRUCTURING-BIND. One way it works is like this (schemified):
;   (define *list* '(1 2 3))
;   (destructuring-bind (a b c) *list*
;     (+ a b c))
;   ===> 6


;; CHALLENGE 14

; Qworkescence | But the last time I wrote an infix parser was for an
;                arithmetic expression parser which recognizes
;                associativity of operands and the natural solution is
;                from our friend Dijkstra and his beautifully simple
;                Shunting Yard algorithm
; Qworkescence | Exercise: Read about & implement shunting yard
; Qworkescence | (in Scheme)


;; CHALLENGE 15

; Qworkescence | qu1j0t3, easy exercise: write the following functions
;                in Scheme equivalent to their Common Lisp counterparts:
;                (CONSTANTLY x) which returns a function which takes
;                any number of args but always returns x

;                and (COMPLEMENT fn) which takes a boolean function fn
;                and returns the logical inverse (NOT) of it

; Qworkescence | CHALLENGE: If COMPLEMENT is the analog of the boolean
;                function NOT, then write two functions (CONJUNCTION f g)
;                which returns a function which takes an argument
;                and checks if both f and g are satisfied.

;                And write (DISJUNCTION f g) which returns a function
;                which takes an argument and checks if either f or g are
;                satisfied

;                (clearly CONJUNCTION is the analog of boolean AND,
;                and DISJUNCTION is the analog of boolean OR)
;                if you have CONJUNCTION, then you can do stuff like...
;                  (define (divisible-by n)
;                    (lambda (x) (zero? (remainder x n))))
;                  (filter (conjunction (disjunction (divisible-by 3)
;                                                    (divisible-by 5))
;                                       (complement (divisible-by 15)))
;                          some-list)
;                filter those elements divisible by 3 or 5 and not 15


;; CHALLENGE 16

; Quadrescence | write (transpose matrix) which transposes.
; Quadrescence | If you don't know what transposition is,
;                every row becomes a column, vice versa


;; CHALLENGE 17

;     qu1j0t3 | Quadrescence: (diagonal? might be a nice scheme challenge..
;Quadrescence | first make a function called "square-matrix?" to see
;               if it's even a matrix
;               then write diagonal? to determine if the matrix is a diagonal
;               matrix


;; CHALLENGE 18

;15:41:53 Quadrescence | FurnaceBoy: Oh, another "small" Scheme challenge:
; Given a list of functions L = (f1 f2 ... fn) and a value x, write a
; function (appList F x) := ((f1 x) (f2 x) ... (fn x))                                                                       ¦
; e.g., if L = (sin cos tan), then (appList L 3.14) gives
; (0.00159265291648683 -0.99999873172754 -0.00159265493640722)


;; CHALLENGE 19

Furthermore, make (appList* L) return a function such that ((appList* L) x) is
equivalent to appList in Challenge 18


;; CHALLENGE 20

Write a macro LOCALS which acts sort of like LET, but allows uninitialized values
(you may initialize them to #f). For example

(locals (a b (c 1) d)
  (set! a 5)
  (+ a c))

returns

  6


;; CHALLENGE 21

Write define-curried which defines a curried function. That is,
(define-curried-function (clog b x) (/ (log x) (log b))), which sets clog to
    (lambda (b)
      (lambda (x)
        (log b x)))


;; CHALLENGE 22

Write (@ f x y z ...) which applies f to x, then the result to y, etc. For
example, (@ clog 2 5) ==> ((clog 2) 5)


;; CHALLENGE 23

The tangent of a number tan(x) is defined as sin(x)/cos(x). We can
compute tangent by using the definition, or we can make use of the
so called "addition formula". The addition formula for tangent is

                tan(a) + tan(b)
  tan(a + b) = ----------------- .
               1 - tan(a)*tan(b)

If we wish to compute tan(x), then we can compute tan(x/2 + x/2):

      x   x     tan(x/2) + tan(x/2)       2*tan(x/2)
  tan(- + -) = --------------------- = ---------------- .
      2   2    1 - tan(x/2)*tan(x/2)   1 - (tan(x/2))^2

We also know something about tangent when the argument is small:

  tan(x) ~= x     when x is very close to 0.

The exercise has two parts:

  (1) Write a recursive function TANGENT using the methods above
      to compute the tangent of a number. It is not necessary to
      handle undefined cases (odd multiples of pi/2).

  (2) Write an iterative version TANGENT-ITER of (1) which avoids
      tree recursion (uses named-LET or tail-recursive procedures).


TEST CASES: Your values need not match these precisely (due to
floating point error and implementation specifics).

> (tangent-iter 0)
0
> (tangent-iter 1.0)
1.5574066357129577
> (tangent-iter 2.0)
-2.1850435345286616
> (tangent-iter (/ 3.14159 4))
0.9999983651876447
