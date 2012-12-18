#|------------------------------------------------------------*-Scheme-*--|
 | File:	    %p%
 |
 |          Contributed by HIROSHI OOTA <oota@POBoxes.com>
 |          as part of the RScheme project, licensed for free use.
 |	    See <http://www.rscheme.org/> for the latest info.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 | Owned by module:  corelib
 |
 | Purpose:          rational number handling
 `------------------------------------------------------------------------|#

(define-syntax (numerator-raw a)
  (mp-rat-numerator a))

(define-syntax (denominator-raw a)
  (mp-rat-denominator a))

(define-glue (raw-rational->double-float a)
{
#if !FULL_NUMERIC_TOWER
    scheme_error( "rational.scm:raw-rational->double-float:~s: function stubbed out", 1, int2fx(__LINE__) ); 
    REG0 = ZERO;
    RETURN1();
#else
  IEEE_64 x = rational_to_raw_float(a);
  REG0 = make_float(x);
  RETURN1();
#endif
})

