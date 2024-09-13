CLASS zcl_triangle DEFINITION "Start of the class definition for zcl_triangle
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    METHODS:
      "! Method to check if the triangle is equilateral
      is_equilateral
        IMPORTING
          side_a             TYPE f   "! Side a of the triangle
          side_b             TYPE f   "! Side b of the triangle
          side_c             TYPE f   "! Side c of the triangle
        RETURNING
          VALUE(result)      TYPE abap_bool  "! Returns true if the triangle is equilateral
        RAISING
          cx_parameter_invalid,   "! Exception if input parameters are invalid
      "! Method to check if the triangle is isosceles
      is_isosceles
        IMPORTING
          side_a             TYPE f   "! Side a of the triangle
          side_b             TYPE f   "! Side b of the triangle
          side_c             TYPE f   "! Side c of the triangle
        RETURNING
          VALUE(result)      TYPE abap_bool  "! Returns true if the triangle is isosceles
        RAISING
          cx_parameter_invalid,   "! Exception if input parameters are invalid
      "! Method to check if the triangle is scalene
      is_scalene
        IMPORTING
          side_a             TYPE f   "! Side a of the triangle
          side_b             TYPE f   "! Side b of the triangle
          side_c             TYPE f   "! Side c of the triangle
        RETURNING
          VALUE(result)      TYPE abap_bool  "! Returns true if the triangle is scalene
        RAISING
          cx_parameter_invalid.   "! Exception if input parameters are invalid

  PROTECTED SECTION. " End of method implementation
  PRIVATE SECTION. " End of class implementation
    METHODS:
      "! Method to validate if the sides form a valid triangle
      is_triangle
        IMPORTING
          side_a             TYPE f   "! Side a of the triangle
          side_b             TYPE f   "! Side b of the triangle
          side_c             TYPE f   "! Side c of the triangle
        RETURNING
          VALUE(result)      TYPE abap_bool  "! Returns true if valid triangle
        RAISING
          cx_parameter_invalid.   "! Exception if input parameters are invalid
ENDCLASS.


CLASS zcl_triangle IMPLEMENTATION.

  METHOD is_triangle.
    "! Check if any of the sides are non-positive, which is invalid for a triangle
    IF side_a <= 0 OR side_b <= 0 OR side_c <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid. "! Raise exception if invalid
    ENDIF.
    "! Check if the sum of two sides is less than the third side (triangle inequality)
    IF side_a + side_b < side_c.
      RAISE EXCEPTION TYPE cx_parameter_invalid. "! Raise exception if invalid
    ENDIF.
    "! Check the triangle inequality for other two sides
    IF side_a + side_c < side_b.
      RAISE EXCEPTION TYPE cx_parameter_invalid. "! Raise exception if invalid
    ENDIF.
    "! Check the triangle inequality for the last pair of sides
    IF side_b + side_c < side_a.
      RAISE EXCEPTION TYPE cx_parameter_invalid. "! Raise exception if invalid
    ENDIF.
  ENDMETHOD.

  METHOD is_equilateral.
    "! Validate that the sides form a valid triangle
    is_triangle(
      side_a = side_a
      side_b = side_b
      side_c = side_c
    ).
    "! Check if all three sides are equal
    " boolc is a built-in function that converts the result of a logical expression into a boolean value ('X' for true or ' ' for false).
    result = boolc( side_a = side_b AND side_a = side_c ).
  ENDMETHOD.

  METHOD is_isosceles.
    "! Validate that the sides form a valid triangle
    is_triangle(
      side_a = side_a
      side_b = side_b
      side_c = side_c
    ).
    "! Check if any two sides are equal
    result = boolc( side_a = side_b OR side_a = side_c OR side_b = side_c ).
  ENDMETHOD.

  METHOD is_scalene.
    "! Validate that the sides form a valid triangle
    is_triangle(
      side_a = side_a
      side_b = side_b
      side_c = side_c
    ).
    "! Check if all three sides are different
    result = boolc( side_a <> side_b AND side_a <> side_c AND side_b <> side_c ).
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
