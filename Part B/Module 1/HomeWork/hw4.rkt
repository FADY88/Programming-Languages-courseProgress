
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; (1) Number Number Number -> (listof Number)
(define (sequence lo hi stride)
  (if (> lo hi)
      null
      (cons lo (sequence (+ lo stride) hi stride))))


;; (2) (listof String) String -> (listof String)
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

;; (3) (listof X) Number -> X
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))


;; (4) Stream Number -> (listof X)
(define (stream-for-n-steps s n)
  (let ([p (s)])
    (if (<= n 0)
        null
        (cons (car p) (stream-for-n-steps (cdr p) (- n 1))))))

;; (5) stream for the sequence [1, 2, 3, 4, -5, 6, 7, 8, 9, -10, ...]
(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= 0 (remainder x 5))
                                    (- x)
                                    x)
                                (lambda () (f (add1 x)))))])
    (lambda () (f 1))))

;; (6) stream for the sequence ["dan.jpg", "dog.jpg", "dan.jpg", ...]
(define dan-then-dog
  (letrec ([f (lambda (s) (cons s (lambda () (f (if (string=? s "dan.jpg")
                                                    "dog.jpg"
                                                    "dan.jpg")))))])
    (lambda () (f "dan.jpg"))))

;; (7) Stream -> Stream
(define (stream-add-zero s)
  (letrec ([p (s)])
    (lambda () (cons (cons 0 (car p)) (stream-add-zero (cdr p))))))

;; (8) (listof X) (listof Y) -> Stream
(define (cycle-lists xs ys)
  (letrec ([helper (lambda (x)
                     (lambda () (cons (cons (list-nth-mod xs x)
                                            (list-nth-mod ys x))
                                      (helper (add1 x)))))])
    (helper 0)))

;; (9) X vector -> Y or false
(define (vector-assoc v vec)
  (letrec ([len (vector-length vec)]
           [helper (lambda (x)
                     (cond [(= x len) #f]
                           [(pair? (vector-ref vec x)) (if (equal? v (car (vector-ref vec x)))
                                                           (vector-ref vec x)
                                                           (helper (add1 x)))]
                           [#t (helper (add1 x))]))])
    (helper 0)))

;; (10) (listof (X . Y)) Number -> (X -> (X . Y))
(define (cached-assoc xs n)
  (letrec ([cache (make-vector n #f)]
           [i 0]
           [helper (lambda (v)
                     (let* ([in-cache (vector-assoc v cache)]
                            [in-xs (if in-cache
                                       #f
                                       (assoc v xs))])
                       (cond [in-cache in-cache]
                             [in-xs (begin (vector-set! cache i in-xs)
                                           (set! i (if (< i n)
                                                       (add1 i)
                                                       0))
                                           (vector-assoc v cache))]
                             [#t #f])))])
    (lambda (v) (helper v))))

;; (11) macro
(define-syntax my-if 
  (syntax-rules (then else)
    [(my-if e1 then e2 else e3)
     (if e1 e2 e3)]))

(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (letrec ([E1 e1]
              [helper (lambda () (if (>= e2 E1)
                                     #t
                                     (helper)))])
       (helper))]))