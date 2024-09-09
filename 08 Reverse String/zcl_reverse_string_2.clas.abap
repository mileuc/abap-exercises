CLASS zcl_reverse_string DEFINITION PUBLIC.
  " Define the class zcl_reverse_string as public

  PUBLIC SECTION.
    " Declare the methods and attributes accessible outside the class
    METHODS reverse_string
      IMPORTING
        input         TYPE string
        " Define the method 'reverse_string' which takes an input parameter of type string
      RETURNING
        VALUE(result) TYPE string.
        " The method returns a string value named 'result'

ENDCLASS.
  " End of class definition

CLASS zcl_reverse_string IMPLEMENTATION.
  " Implementation of the class zcl_reverse_string

  METHOD reverse_string.
    " Implementation of the 'reverse_string' method

    " Please complete the implementation of the reverse_string method
    " The comment indicates that the method implementation needs to be completed

    DATA : lv_str    TYPE string,
           lv_len    TYPE i.
    " Declare local variables:
    " - lv_str to hold the input string
    " - lv_len to hold the length of the string

    lv_str = input.
    " Assign the input parameter to the local variable lv_str

    IF lv_str IS INITIAL.
      " Check if the input string is empty or initial

      result = ''.
      " Set the result to an empty string if the input is initial

    ELSE.
      " If the input string is not initial

      lv_len = strlen( lv_str ).
      " Calculate the length of the input string and assign it to lv_len

      DO lv_len TIMES.
        " Loop through the length of the string, once for each character

        lv_len = lv_len - 1.
        " Decrease lv_len by 1 to get the index of the character from the end

        CONCATENATE  result lv_str+lv_len(1) INTO  result.
        " Append the character at position lv_len to the result string
        " Use the CONCATENATE statement to build the reversed string
        " lv_str+lv_len(1): This syntax extracts a single character from lv_str at position lv_len. 
        " The + symbol is used to specify the starting position, and (1) indicates the length of the substring to extract (i.e., one character)."
        "INTO result: This specifies that the concatenated string (which is the current result plus the new character) should be stored back in result."

      ENDDO.
      " End of loop

    ENDIF.
    " End of IF-ELSE block

  ENDMETHOD.
  " End of method implementation

ENDCLASS.
  " End of class implementation

" Example: DO loop
" Let’s assume input is "ABCD".
    " Initially, lv_len is set to 4 (the length of "ABCD").

    " First Iteration:
        " lv_len becomes 4 - 1 = 3.
        " lv_str+3(1) extracts the character 'D'.
        " result is updated to "D".

    " Second Iteration:
        " lv_len becomes 3 - 1 = 2.
        " lv_str+2(1) extracts the character 'C'.
        " result is updated to "DC".

    " Third Iteration:
        " lv_len becomes 2 - 1 = 1.
        " lv_str+1(1) extracts the character 'B'.
        " result is updated to "DCB".

    " Fourth Iteration:
        " lv_len becomes 1 - 1 = 0.
        " lv_str+0(1) extracts the character 'A'.
        " result is updated to "DCBA".

" After the loop completes, result contains the reversed string "DCBA"."
