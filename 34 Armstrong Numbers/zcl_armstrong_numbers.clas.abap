CLASS zcl_armstrong_numbers DEFINITION "Start of the class definition for zcl_armstrong_numbers
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared

    "! Method to check if a number is an Armstrong number
    METHODS is_armstrong_number IMPORTING num           TYPE i           " Input parameter: the number to check
                                RETURNING VALUE(result) TYPE abap_bool.   " Output parameter: boolean result indicating if the number is an Armstrong number
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_armstrong numbers
CLASS zcl_armstrong_numbers IMPLEMENTATION.

  "! Implementation of the method to check if a number is an Armstrong number
  METHOD is_armstrong_number.

    "! Variable to store the calculated sum of the digits raised to the power of their count
    " Declares an integer variable test to accumulate the sum of each digit raised to the power of the total number of digits.
    DATA test TYPE i.

    "! Variable to store the current position or offset within the string representation of the number
    " Declares an integer variable offset to keep track of the current digit position in the string representation of the number.
    DATA offset TYPE i.

    "! Convert the input number to a string representation to facilitate digit extraction
    DATA(s) = |{ num }|.

    "! Loop through each digit of the number string
    DO strlen( s ) TIMES.

      "! Raise the current digit (extracted using offset) from the string representation of the number, to the power of the total number of digits and add to 'test'
      test += s+offset(1) ** strlen( s ).

      "! Move to the next digit by increasing the offset
      offset += 1.

    ENDDO.  "! End of loop after processing all digits

    "! Compare the calculated sum ('test') with the original number ('num') to determine if it's an Armstrong number
    " test = num: Checks if the accumulated sum test equals the original number num.
    " boolc(...): Converts the comparison result into a boolean value (ABAP_TRUE or ABAP_FALSE).
    result = boolc( test = num ).

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
