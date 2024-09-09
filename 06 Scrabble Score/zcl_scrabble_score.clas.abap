CLASS zcl_scrabble_score DEFINITION PUBLIC .
  " Define the class zcl_scrabble_score as publicly accessible

  PUBLIC SECTION.
    " Declare the methods and attributes accessible outside the class
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
        " Define the method 'score' which takes an optional input of type string
      RETURNING
        VALUE(result) TYPE i.
        " The method returns an integer value named 'result'

  PROTECTED SECTION.
  " Section for attributes and methods that are accessible within the class and its subclasses

  PRIVATE SECTION.
  " Section for attributes and methods that are accessible only within the class

ENDCLASS.
  " End of class definition

CLASS zcl_scrabble_score IMPLEMENTATION.
  " Implementation of the class zcl_scrabble_score

  METHOD score.
    " Implementation of the 'score' method

    result = count( val = input regex = '[aeioulnrst]' case = abap_false ) * 1 +
      " Count occurrences of letters with value 1 and multiply by 1
      " Counts the number of occurrences of each letter in the input string that matches the regular expression [aeioulnrst]. 
      " This regex matches all letters that have a Scrabble value of 1 (A, E, I, O, U, L, N, R, S, T)."
      " Each of these letters has a value of 1, so we multiply the count by 1. 
      " This is essentially redundant but included for clarity and consistency with other score calculations."
      count( val = input regex = '[dg]' case = abap_false ) * 2 +
      " Count occurrences of letters with value 2 and multiply by 2
      count( val = input regex = '[bcmp]' case = abap_false ) * 3 +
      " Count occurrences of letters with value 3 and multiply by 3
      count( val = input regex = '[fhvwy]' case = abap_false ) * 4 +
      " Count occurrences of letters with value 4 and multiply by 4
      count( val = input regex = '[k]' case = abap_false ) * 5 +
      " Count occurrences of letter 'k' with value 5 and multiply by 5
      count( val = input regex = '[jx]' case = abap_false ) * 8 +
      " Count occurrences of letters with value 8 and multiply by 8
      count( val = input regex = '[qz]' case = abap_false ) * 10.
      " Count occurrences of letters with value 10 and multiply by 10

  ENDMETHOD.
  " End of method implementation

ENDCLASS.
  " End of class implementation

" Summary
" The score method uses the count function with regular expressions to determine the number of each letter in the input string that corresponds to different Scrabble letter values. 
" It then calculates the total score by multiplying these counts by their respective letter values and summing them up. 
" The result is the total Scrabble score for the given word.
