CLASS zcl_raindrops DEFINITION "Start of the class definition for zcl_itab_nesting
  PUBLIC. "The class is publicly accessible
  PUBLIC SECTION. " Public section of the class where types and methods are declared
    METHODS raindrops
      IMPORTING
        input         TYPE i        " Input parameter: the number to convert into raindrop sounds
      RETURNING
        VALUE(result) TYPE string. " Return value: the resulting raindrop sounds as a string
ENDCLASS.

" Begin implementation of the class zcl_raindrops
CLASS zcl_raindrops IMPLEMENTATION.

  METHOD raindrops.
    " Check if the input number is divisible by 3
    IF input MOD 3 = 0.
      " Append 'Pling' to the result string if divisible by 3
      result = |{ result }Pling|.
    ENDIF.

    " Check if the input number is divisible by 5
    IF input MOD 5 = 0.
      " Append 'Plang' to the result string if divisible by 5
      result = |{ result }Plang|.
    ENDIF.

    " Check if the input number is divisible by 7
    IF input MOD 7 = 0.
      " Append 'Plong' to the result string if divisible by 7
      result = |{ result }Plong|.
    ENDIF.

    " Check if result is still initial (i.e., empty or unmodified)
    IF result IS initial.
      " If result is still empty, set it to the string representation of the input number
      result = input.
    ENDIF.
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
