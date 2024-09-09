CLASS zcl_grains DEFINITION "Start of the class definition for zcl_grains
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION.
    " Define a type for result with precision of 16 digits and no decimals.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.

    " Define a method 'square' to calculate grains on a specific square.
    METHODS square
      IMPORTING
        input         TYPE i " The input parameter 'input' represents the square number (1 to 64).
      RETURNING
        VALUE(result) TYPE type_result " The method returns the number of grains on the given square.
      RAISING
        cx_parameter_invalid. " This method can raise an exception if the input is invalid.

    " Define a method 'total' to calculate the total number of grains on the chessboard.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result " The method returns the total number of grains on the chessboard.
      RAISING
        cx_parameter_invalid. " This method can raise an exception if there is an issue.
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)

ENDCLASS. " End of class definition

" Begin implementation of the class zcl_grains
CLASS zcl_grains IMPLEMENTATION.

  METHOD square. "Calculates the number of grains on a given square."
    result = 1. " Initialize the result to 1 (grains on the first square).

    IF input > 0 AND input < 65. " Check if the input is between 1 and 64 inclusive.
      DO ( input - 1 ) times. " Loop (input - 1) times to calculate grains for the specified square.
        result = result * 2. " Double the number of grains for each iteration.
      ENDDO. " End of the loop.
    ELSE. " If input is not within the valid range:
      RAISE EXCEPTION TYPE cx_parameter_invalid. " Raise an exception for invalid input.
    ENDIF. " End of the IF condition.
  ENDMETHOD. " End of method implementation

  METHOD total.  " Calculates the total number of grains on the chessboard. "
    data: iterator type i Value 1. " Initialize a local variable 'iterator' to 1.
    DO 63 times. " Loop 63 times to calculate the total grains (since the first square is already counted).
      iterator = iterator * 2. " Double the 'iterator' value in each iteration.
      result = result + iterator. " Add the doubled value to the result to get the total grains.
    ENDDO. " End of the loop.
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
