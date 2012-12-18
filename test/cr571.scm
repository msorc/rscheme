#|------------------------------------------------------------*-Scheme-*--|
 | File:    %p%
 |
 |          Copyright (C)1997 Donovan Kolbly <d.kolbly@rscheme.org>
 |          as part of the RScheme project, licensed for free use.
 |          See <http://www.rscheme.org/> for the latest information.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 |
 `------------------------------------------------------------------------|#

;;;
;;;  define a metaclass
;;;

(define-class <<tracked>> (<<standard-class>>)
  (subclasses type: <list> init-value: '()))

(define-method add-subclass! ((self <<class>>) ch)
  (values))

(define-method add-subclass! ((self <<tracked>>) ch)
  (set-subclasses! self (cons ch (subclasses self)))
  (values))

(define-method initialize ((self <<tracked>>))
  (next-method)
  (add-subclass! (car (superclasses self)) self))

;;;

(define-class <point> (<object>)
  metaclass: <<tracked>>
  (x type: <number> init-value: 0)
  (y type: <number> init-value: 0))

(define-class <colored-point> (<point>)
  metaclass: <<tracked>>
  (color type: <symbol> init-value: 'black))

(define-class <end-point> (<point>)
  metaclass: <<tracked>>
  friend)

;;;

(test-section
 (metaclass)
 ;;
 (test-section 
  (initialization)
  (check (list <end-point> <colored-point>)
	 (subclasses <point>))))
