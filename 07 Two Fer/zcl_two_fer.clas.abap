CLASS zcl_two_fer DEFINITION PUBLIC.
  " Define the class zcl_two_fer as public

  PUBLIC SECTION.
    " Declare the methods and attributes accessible outside the class
    METHODS two_fer
      IMPORTING
        input         TYPE string DEFAULT 'you'
        " Define the method 'two_fer' which takes an optional input of type string
        " with a default value of 'you'
      RETURNING
        VALUE(result) TYPE string.
        " The method returns a string value named 'result'

ENDCLASS.
  " End of class definition

CLASS zcl_two_fer IMPLEMENTATION.
  " Implementation of the class zcl_two_fer

  METHOD two_fer.
    " Implementation of the 'two_fer' method

    result = |One for { input }, one for me.|.
    " Use string interpolation to create a formatted string where '{ input }'
    " is replaced by the value of the input parameter, and then assign it to 'result'

  ENDMETHOD.
  " End of method implementation

ENDCLASS.
  " End of class implementation

" Example of how an instance of this class would be created and the two_fer method called
"DATA: lv_result TYPE string.
"DATA: lo_two_fer TYPE REF TO zcl_two_fer.

" Create an instance of the zcl_two_fer class
"CREATE OBJECT lo_two_fer.

" Call the two_fer method with a specific name
"lv_result = lo_two_fer->two_fer( input = 'Alice' ).

" Output the result
"WRITE: / lv_result.

" Call the two_fer method with the default name
"lv_result = lo_two_fer->two_fer( ).

" Output the result
"WRITE: / lv_result.
