CLASS zcl_phone_number DEFINITION "Start of the class definition for zcl_phone_number.clas.abap
  PUBLIC  "The class is publicly accessible
  FINAL   "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared

    METHODS clean
      " Remove all non-numeric characters from the input number
      IMPORTING
        !number       TYPE string           " Input phone number as a string
      RETURNING
        VALUE(result) TYPE string           " Returns cleaned phone number as a string
      RAISING
        cx_parameter_invalid.               " Raises an exception if the number is invalid
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_phone_number
CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
    " Remove all non-numeric characters from the input number
    " Replace function in ABAP is used to search for a pattern (specified by a regular expression) within a string and replace it with a different substring.
    " ^: In regex, ^ inside square brackets ([]) means "not" or "negate.
    " So, [^0-9] matches any character that is not a digit
    " occ: This parameter specifies the number of occurrences of the pattern to replace.
    " 0: Instructs the function to replace all occurrences of the pattern found in the input string. It means every non-digit character in the input will be removed."
    result = replace( val   = number        " Original phone number
                      regex = |[^0-9]|      " Regular expression to match non-digit characters
                      with  = ``            " Replace non-digits with an empty string
                      occ   = 0 ).          " Replace all occurrences

    " Check if the cleaned number has 11 digits and starts with '1' (country code)
    " expression result+offset(length) is a way to perform substring operations on strings, where:
    " result: The variable holding the string you want to manipulate or analyze.
    " +offset: The starting position from where you want to extract a substring. In ABAP, string indexing is 0-based, meaning the first character has an offset of 0. Here, 0 means to start at the very beginning of the string, i.e., the first character.
    "(length): The length of the substring to extract, starting from the specified offset."
    IF strlen( result ) = 11 AND result+0(1) = '1'.
      " result+1 (on the right-hand side): This is the part of the expression that extracts a substring from result.
      " The offset 1 indicates that we start extracting the substring from the second character of result
      " Thus, result+1 takes the substring of result starting from the second character and extending to the end of the string and effectively removes the first character of the string result.
      result = result+1.                    " Remove the leading '1' if it is the country code
    ENDIF.

    " If the length of the cleaned number is not 10, raise an exception
    IF strlen( result ) <> 10.
        RAISE EXCEPTION TYPE cx_parameter_invalid. " Raise exception for invalid phone numbers
    ENDIF.

    " Check if the first digit of the area code or the exchange code is less than or equal to '1'
    IF result+0(1) <= '1' OR result+3(1) <= '1'.
        RAISE EXCEPTION TYPE cx_parameter_invalid. " Raise exception if area or exchange code is invalid
    ENDIF.
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
