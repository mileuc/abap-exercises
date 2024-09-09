CLASS zcl_resistor_color DEFINITION " Start of the class definition for zcl_resistor_color
  PUBLIC " The class is publicly accessible
  CREATE PUBLIC. " Allows public creation of instances
  PUBLIC SECTION. " Public section of the class where types and methods are declared
    " Define a public method 'resistor_color' which takes a color code and returns a value.
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string " The input parameter 'color_code' is of type string.
      RETURNING
        VALUE(value) TYPE i. " The method returns an integer value corresponding to the color code.
ENDCLASS. " End of class definition

CLASS zcl_resistor_color IMPLEMENTATION.

  " Begin implementation of method resistor color
  METHOD resistor_color.
    " The method implementation begins here.
    CASE color_code. " Check the value of 'color_code' and match it against the defined cases.
      WHEN 'black'. " If 'color_code' is 'black', then:
        value = 0. " Set 'value' to 0.
      WHEN 'brown'. " If 'color_code' is 'brown', then:
        value = 1. " Set 'value' to 1.
      WHEN 'red'. " If 'color_code' is 'red', then:
        value = 2. " Set 'value' to 2.
      WHEN 'orange'. " If 'color_code' is 'orange', then:
        value = 3. " Set 'value' to 3.
      WHEN 'yellow'. " If 'color_code' is 'yellow', then:
        value = 4. " Set 'value' to 4.
      WHEN 'green'. " If 'color_code' is 'green', then:
        value = 5. " Set 'value' to 5.
      WHEN 'blue'. " If 'color_code' is 'blue', then:
        value = 6. " Set 'value' to 6.
      WHEN 'violet'. " If 'color_code' is 'violet', then:
        value = 7. " Set 'value' to 7.
      WHEN 'grey'. " If 'color_code' is 'grey', then:
        value = 8. " Set 'value' to 8.
      WHEN 'white'. " If 'color_code' is 'white', then:
        value = 9. " Set 'value' to 9.
    ENDCASE. " End of the CASE statement.
  ENDMETHOD. " End of the method implementation.

ENDCLASS. " End of the class definition.

