CLASS zcl_prime_factors DEFINITION "Start of the class definition for zcl_itab_nesting
  PUBLIC "The class is publicly accessible
  FINAL "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    " Define a type for a table of integers with an empty key
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    " Method to compute the prime factors of a given integer
    METHODS factors
      IMPORTING
        input         TYPE int8 " Input number to find the prime factors of
      RETURNING
        VALUE(result) TYPE integertab. " List of prime factors of the input number
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_prime_factors
CLASS zcl_prime_factors IMPLEMENTATION.

  METHOD factors.
    " Create a temporary variable to work with the input number
    DATA(temp_input) = input.

    " Initialize the divisor to the smallest prime number
    DATA(divisor) = 2.

    " Continue finding factors while the temporary input is greater than 1
    WHILE temp_input > 1.
      " While the temporary input is not divisible by the current divisor
      WHILE temp_input MOD divisor <> 0.
        " Increment the divisor to check the next possible prime number
        divisor = divisor + 1.
      ENDWHILE.

      " Append the current divisor to the result list (a prime factor found)
      APPEND divisor TO result.

      " Divide the temporary input by the current divisor to reduce the number
      temp_input = temp_input / divisor.
    ENDWHILE.
  ENDMETHOD. " End of method implementation
ENDCLASS.    " End of class implementation
