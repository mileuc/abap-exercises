CLASS zcl_anagram DEFINITION "Start of the class definition for zcl_anagrams
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    METHODS anagram
      "Takes a target word and a table of candidate words and returns a table of anagrams
      IMPORTING
        input         TYPE string        " Input target word for finding anagrams
        candidates    TYPE string_table  " Table of candidate words to be checked
      RETURNING
        VALUE(result) TYPE string_table. " Table of anagram results
    METHODS sort_string
    "Takes a word, sorts its letters, and returns the sorted word
      IMPORTING
        input         TYPE string        " Input word to be sorted
      RETURNING
        VALUE(result) TYPE string.       " Sorted string of the input word
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_anagram
CLASS zcl_anagram IMPLEMENTATION.

  METHOD anagram.
    " Loop through each candidate in the candidates table
    LOOP AT candidates ASSIGNING FIELD-SYMBOL(<candidate>).
      " Check if the sorted version of the input is equal to the sorted version of the candidate
      " and ensure the input is not equal to the candidate itself
      IF sort_string( input ) = sort_string( <candidate> ) AND to_lower( input ) <> to_lower( <candidate> ).
        " Append the candidate to the result table if it is an anagram
        APPEND <candidate> TO result.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD sort_string.
    " Declare an internal table to hold individual letters of the input
    DATA input_letters TYPE string_table.

    " Convert the input string to lowercase for case-insensitive comparison
    DATA(input_lower) = to_lower( input ).

    " Determine the length of the lowercase input string
    DATA(do_count) = strlen( input_lower ).

    " Initialize index variable
    DATA(index) = 0.

    " Loop over each character in the lowercase input string
    DO do_count TIMES.
      " Set index to current loop iteration (adjusted for zero-based indexing)
      index = sy-index - 1.
      " Append the character at the current index to the input_letters table
      " input_lower is the string variable, and index is the position from which we want to extract a single character."
      APPEND input_lower+index(1) TO input_letters.
    ENDDO.

    " Sort the input_letters table alphabetically
    SORT input_letters.

    " Initialize result as an empty string
    LOOP AT input_letters ASSIGNING FIELD-SYMBOL(<letter>).
      " Concatenate each sorted letter to the result string
      result = |{ result }{ <letter> }|.
    ENDLOOP.

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
