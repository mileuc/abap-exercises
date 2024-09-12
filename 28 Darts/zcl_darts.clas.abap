CLASS zcl_darts DEFINITION " Define a new class 'zcl_darts'
  PUBLIC " Class is public, so it can be accessed globally
  FINAL " Class is final, meaning it cannot be inherited
  CREATE PUBLIC. " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside
    METHODS score " Define a method 'score' to calculate the points earned from a dart throw
      IMPORTING " Import parameters into the method
        x             TYPE f " X-coordinate of the dart landing point (float)
        y             TYPE f " Y-coordinate of the dart landing point (float)
      RETURNING " Returning parameter
        VALUE(result) TYPE i. " Result is the integer points earned
  PROTECTED SECTION. " Protected section (not used in this class)
  PRIVATE SECTION. " Private section (not used in this class)

ENDCLASS. " End of class definition

CLASS zcl_darts IMPLEMENTATION. " Begin class implementation
  METHOD score. " Implementation of the 'score' method

    " Calculate the distance 'r' from the dart landing point (x, y) to the center (0, 0) using the Pythagorean theorem
    DATA(r) = sqrt( x * x + y * y ).

    " Check if the distance 'r' is within the inner circle (radius 1)
    IF 0 <= r AND r <= 1.
      result = 10. " Assign 10 points if 'r' is within the inner circle

    " Check if the distance 'r' is within the middle circle (radius 5)
    ELSEIF 1 < r AND r <= 5.
      result = 5. " Assign 5 points if 'r' is within the middle circle

    " Check if the distance 'r' is within the outer circle (radius 10)
    ELSEIF 5 < r AND r <= 10.
      result = 1. " Assign 1 point if 'r' is within the outer circle

    " If the dart lands outside the target (r > 10)
    ELSE.
      result = 0. " Assign 0 points if 'r' is outside the target
    ENDIF. " End of conditional statements

  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
