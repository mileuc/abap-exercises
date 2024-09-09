CLASS zcl_clock DEFINITION "Start of the class definition for zcl_clock
  PUBLIC "The class is publicly accessible
  CREATE PUBLIC. " Specifies that instances of this class can be created publicly

  PUBLIC SECTION. " Public section of the class where types and methods are declared

    METHODS constructor
      IMPORTING
        "! symbol before a parameter in method signatures or other places is used to denote the parameter name in a more explicit manner.
        !hours   TYPE i " Number of hours to initialize the clock
        !minutes TYPE i DEFAULT 0. " Number of minutes to initialize the clock, default value is 0
    METHODS get
      RETURNING
        VALUE(result) TYPE string. " Method to get the current time as a string
    METHODS add
      IMPORTING
        !minutes TYPE i. " Number of minutes to add to the clock
    METHODS sub
      IMPORTING
        !minutes TYPE i. " Number of minutes to subtract from the clock

  PRIVATE SECTION. " Private section of the class 
    DATA clock TYPE t. " Internal data to hold the time in seconds

ENDCLASS. " End of class definition

CLASS zcl_clock IMPLEMENTATION. " Begin implementation of the class zcl_clock

  METHOD add.
  "Adds a specified number of minutes to the clock."
    clock = clock + (minutes * 60). " Add the number of minutes (converted to seconds) to the clock
  ENDMETHOD.

  METHOD constructor.
    " Clock is number of seconds
    clock = (hours * 60 * 60) + (minutes * 60). " Initialize the clock with hours and minutes converted to seconds
  ENDMETHOD.

  METHOD get.
    "Formats and retrieves the current time from the clock as a string in hh:mm format.
    " hh:mm:ss
    result = |{ clock TIME = ISO }|. " Format the clock time in ISO standard format (hh:mm:ss)
    "|{ clock TIME = ISO }|: This is a string template. In ABAP, you can use {} within a string literal to insert variables or expressions. Here, clock is being formatted as a time string."
    "clock TIME = ISO: This part of the template tells ABAP to format the clock variable using the ISO time format, which is hh:mm:ss. ISO stands for the International Standard Organization's time format."
    "result = |{ clock TIME = ISO }|.: This line assigns the formatted time string (in hh:mm:ss format) to the result variable."
    " return only hh:mm
    result = result(5). " Extract the hours and minutes part from the formatted result
    "result(5): This syntax extracts a substring from the result string. Specifically, result(5) takes the first 5 characters of the result string.
    "For the format hh:mm:ss, the first 5 characters represent hh:mm.
  ENDMETHOD.

  METHOD sub.
  "Subtracts a specified number of minutes from the clock.
    clock = clock - (minutes * 60_. " Subtract the number of minutes (converted to seconds) from the clock
  ENDMETHOD.

ENDCLASS. "End of class implementation
