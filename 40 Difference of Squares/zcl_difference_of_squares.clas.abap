CLASS zcl_difference_of_squares DEFINITION "Start of the class definition for zcl_difference_of_squares
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    METHODS:
      ret_difference_of_squares IMPORTING num         TYPE i  " Method to calculate the difference between the square of the sum and the sum of the squares
                                RETURNING VALUE(diff) TYPE i, " Returns the difference as an integer
      ret_sum_of_squares        IMPORTING num         TYPE i  " Method to calculate the sum of the squares of the first 'num' natural numbers
                                RETURNING VALUE(sum_of_squares) TYPE i, " Returns the sum of the squares as an integer
      ret_square_of_sum         IMPORTING num         TYPE i  " Method to calculate the square of the sum of the first 'num' natural numbers
                                RETURNING VALUE(square_of_sum) TYPE i. " Returns the square of the sum as an integer
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_difference_of_squares
CLASS zcl_difference_of_squares IMPLEMENTATION.
  METHOD ret_difference_of_squares.
  " Method to calculate the difference between the square of the sum and the sum of the squares
    diff = ret_square_of_sum( num ) - ret_sum_of_squares( num ). " Calculate the difference by calling both methods and subtracting the sum of squares from the square of the sum
  ENDMETHOD.

  METHOD ret_sum_of_squares.
    " Method to calculate the sum of the squares of the first 'num' natural numbers
    DO num TIMES.                                   " Loop from 1 to 'num'
      sum_of_squares += sy-index ** 2.              " Add the square of the current index (sy-index) to the running total of sum_of_squares
    ENDDO.
  ENDMETHOD.

  METHOD ret_square_of_sum.
  " Method to calculate the square of the sum of the first 'num' natural numbers
    DO num TIMES.                                   " Loop from 1 to 'num'
      square_of_sum += sy-index.                    " Add the current index (sy-index) to the running total of square_of_sum
    ENDDO.
    square_of_sum = square_of_sum ** 2.             " Square the total sum to get the square of the sum
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
