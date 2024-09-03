CLASS zcl_hello_world DEFINITION PUBLIC.      " Define a new class named 'zcl_hello_world' with public visibility
  PUBLIC SECTION.                             " Start the public section of the class
    METHODS hello RETURNING VALUE(result) TYPE string. " Declare a method 'hello' that returns a value 'result' of type string
ENDCLASS.                                      " End of class definition

CLASS zcl_hello_world IMPLEMENTATION.          " Start the implementation of the class 'zcl_hello_world'

  METHOD hello.                                " Start the method implementation for 'hello'
    result = 'Hello, World!'.                  " Assign the string 'Hello, World!' to the returning variable 'result'
  ENDMETHOD.                                   " End of the method 'hello'

ENDCLASS.                                      " End of class implementation
