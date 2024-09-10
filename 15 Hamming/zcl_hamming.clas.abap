CLASS zcl_hamming DEFINITION "Start of the class definition for zcl_hamming
  PUBLIC. "The class is publicly accessible
  PUBLIC SECTION. "Allows public creation of instances
    "Define a method named hamming_distance with two input parameters and a return value"
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string "First DNA strand to compare"
        second_strand TYPE string "Second DNA strand to compare"
      RETURNING
        VALUE(result) TYPE i "Return type of the Hamming distance (integer)"
      RAISING
        cx_parameter_invalid. "Exception to be raised if input strands are of unequal length"
ENDCLASS. " End of class definition

" Begin implementation of the class zcl_hamming
CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    DATA i TYPE i. "Local variable to iterate over the strand characters"

    "Check if the lengths of the two strands are equal; raise an exception if they are not"
    IF strlen( first_strand ) <> strlen( second_strand ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
 
    i = 0. "Initialize the counter variable for iteration"
    
    "Loop over each character in the DNA strands"
    DO strlen( first_strand ) TIMES.
      "Compare characters at the current position in both strands"
      "In the first iteration, off is 0, which tells the substring function to start extracting the character from the 0th position (the first character) of the string."
      IF substring( val = first_strand
                    off = i
                    len = 1 ) <> substring( val = second_strand 
                                            off = i
                                            len = 1 ).
        result = result + 1. "Increment the result if characters do not match"
      ENDIF.
      i = i + 1. "Move to the next position in the strands"
    ENDDO.
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
