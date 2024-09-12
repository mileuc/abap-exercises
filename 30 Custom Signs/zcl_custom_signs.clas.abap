CLASS zcl_custom_signs DEFINITION " Define a new class 'zcl_custom_signs'
  PUBLIC " Class is public, so it can be accessed globally
  FINAL " Class is final, meaning it cannot be inherited
  CREATE PUBLIC. " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside

    "! Define a method to build a sign with a custom message using the occasion and name
    METHODS build_sign IMPORTING occasion      TYPE string " Input parameter for the occasion (e.g., 'Birthday')
                                 name          TYPE string " Input parameter for the person's name (e.g., 'Rob')
                       RETURNING VALUE(result) TYPE string. " Returns the generated sign as a string

    "! Define a method to build a birthday sign that formats the message based on age
    METHODS build_birthday_sign IMPORTING age           TYPE i " Input parameter for the person's age
                                RETURNING VALUE(result) TYPE string. " Returns the formatted birthday sign

    "! Define a method to build a graduation sign with the name and year on separate lines
    METHODS graduation_for IMPORTING name          TYPE string " Input parameter for the graduate's name
                                     year          TYPE i " Input parameter for the graduation year
                           RETURNING VALUE(result) TYPE string. " Returns the formatted graduation sign

    "! Define a method to determine the cost of a sign based on the content and currency
    METHODS cost_of IMPORTING sign          TYPE string " Input parameter for the content of the sign
                              currency      TYPE string " Input parameter for the currency type (e.g., 'euros')
                    RETURNING VALUE(result) TYPE string. " Returns the cost of the sign as a string with the currency

ENDCLASS. " End of class definition


CLASS zcl_custom_signs IMPLEMENTATION. " Begin class implementation


  METHOD build_sign. " Implementation of the 'build_sign' method
    " Use string templates to generate a message for the occasion sign
    result = |Happy { occasion } { name }!|. " Format the string with the occasion and name parameters
  ENDMETHOD. " End of method implementation


  METHOD build_birthday_sign. " Implementation of the 'build_birthday_sign' method
    " Use a conditional expression (COND) to check if age is 50 or older and format the message accordingly
    result = |Happy Birthday! What a { COND #( WHEN age >= 50 THEN 'mature' ELSE 'young' ) } fellow you are.|. " Return a birthday message based on age
  ENDMETHOD. " End of method implementation


  METHOD graduation_for. " Implementation of the 'graduation_for' method
    " Use string templates to create a graduation message with the name and year on separate lines
    result = |Congratulations { name }!\nClass of { year }|. " Format the graduation sign with name and year
  ENDMETHOD. " End of method implementation


  METHOD cost_of. " Implementation of the 'cost_of' method
    " Calculate the total cost based on a base price and additional cost per character in the sign
    DATA(price) = 20 + strlen( sign ) * 2. " Calculate the cost: base price 20 plus 2 per character in the sign
    " Use string templates to format the result string with the calculated price and currency, ensuring two decimal places
    result = |Your sign costs { price DECIMALS = 2 } { currency }.|. " Return the total cost formatted with two decimals
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
