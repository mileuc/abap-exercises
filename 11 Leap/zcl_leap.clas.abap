CLASS zcl_leap DEFINITION PUBLIC. " Start of the class definition for zcl_leap
  PUBLIC SECTION. " Public section of the class where types and methods are declared
    " Define a public method 'leap' which determines if a given year is a leap year.
    METHODS leap
      IMPORTING
        year          TYPE i " The input parameter 'year' is of type integer.
      RETURNING
        VALUE(result) TYPE abap_bool. " The method returns a boolean value indicating if the year is a leap year.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.
    " The method implementation starts here.
    IF year MOD 4 = 0. " Check if 'year' is divisible by 4.
      IF year MOD 100 = 0. " Check if 'year' is also divisible by 100.
        IF year MOD 400 = 0. " Check if 'year' is also divisible by 400.
          result = abap_true. " If divisible by 400, it is a leap year. Set 'result' to true.
        ELSE. " If not divisible by 400:
          result = abap_false. " It is not a leap year. Set 'result' to false.
        ENDIF. " End of the third IF condition.
      ELSE. " If not divisible by 100:
        result = abap_true. " It is a leap year. Set 'result' to true.
      ENDIF. " End of the second IF condition.
    ELSE. " If not divisible by 4:
      result = abap_false. " It is not a leap year. Set 'result' to false.
    ENDIF. " End of the first IF condition.
  ENDMETHOD. " End of the method implementation.

ENDCLASS. " End of the class definition.

"IF year MOD 4 = 0:

    "This checks if the year is divisible by 4. If the result is 0, the year is divisible by 4 and might be a leap year. 
    "If this condition fails, the year is not a leap year.

"IF year MOD 100 = 0:

    "If the year is divisible by 4, this checks if it is also divisible by 100.
    "If true, it could be a leap year only if it satisfies the next condition.

"IF year MOD 400 = 0:

    "If the year is divisible by 100, this checks if it is also divisible by 400.
    "If true, the year is a leap year. If false, the year is not a leap year.

" result = abap_true or result = abap_false:

    " These lines set the result variable to either true or false based on the conditions checked.
