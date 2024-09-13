CLASS zcl_collatz_conjecture DEFINITION "Start of the class definition for zcl_collatz_conjecture 
  PUBLIC  "The class is publicly accessible
  FINAL   "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    "! Method to calculate the number of steps to reach 1 using the Collatz Conjecture
    METHODS ret_steps IMPORTING num          TYPE i                 " Input parameter: the starting number
                      RETURNING VALUE(steps) TYPE i                 " Output parameter: number of steps to reach 1
                      RAISING   cx_parameter_invalid.               " Exception raised if the input parameter is invalid (i.e., not a positive integer)
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_collatz_conjecture 
CLASS zcl_collatz_conjecture IMPLEMENTATION.

  "! Implementation of the method to compute steps for the Collatz Conjecture
  METHOD ret_steps.

    "! Initialize a local variable 'c' with the input number
    DATA(c) = num.

    "! Check if the input number is less than 1; if so, raise an exception
    IF c < 1. 
      RAISE EXCEPTION TYPE cx_parameter_invalid. " Raise an exception if the input number is invalid
    ENDIF.

    "! Loop until the number 'c' is reduced to 1
    WHILE c > 1.

      "! Apply the Collatz rule: if 'c' is even, divide by 2; if odd, multiply by 3 and add 1
      " COND #(...): Conditional expression to update the value of c based on whether it is even or odd.
      " c MOD 2 = 0: Checks if the current value of c is even.
      " THEN c / 2: If c is even, divides c by 2.
      " ELSE c * 3 + 1: If c is odd, multiplies c by 3 and adds 1.
      c = COND #( WHEN c MOD 2 = 0 THEN c / 2 ELSE c * 3 + 1 ).

      "! Increment the step count after each operation
      steps += 1.
    ENDWHILE.
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
