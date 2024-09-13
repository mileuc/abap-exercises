CLASS zcl_etl DEFINITION "Start of the class definition for zcl_etl
  PUBLIC "The class is publicly accessible
  FINAL "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    TYPES:
      BEGIN OF ty_legacy_data, " Define a structure to hold legacy data
        number TYPE i,          " Integer value representing the score
        string TYPE string,     " String of letters in legacy format
      END OF ty_legacy_data,
      BEGIN OF ty_new_data,    " Define a structure to hold new data format
        letter TYPE c LENGTH 1, " Single character representing the letter
        number TYPE i,          " Integer value representing the score
      END OF ty_new_data,
      tty_legacy_data TYPE SORTED TABLE OF ty_legacy_data WITH UNIQUE KEY number, " Define a sorted table for legacy data with unique key on 'number'
      tty_new_data    TYPE SORTED TABLE OF ty_new_data WITH UNIQUE KEY letter.      " Define a sorted table for new data with unique key on 'letter'

    METHODS transform IMPORTING legacy_data     TYPE tty_legacy_data " Method to transform legacy data to new data format
                      RETURNING VALUE(new_data) TYPE tty_new_data.   " Returns the transformed new data

  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS. " End of class definition


CLASS zcl_etl IMPLEMENTATION.
  METHOD transform.
    " Method to transform legacy data to new data format
    LOOP AT legacy_data ASSIGNING FIELD-SYMBOL(<data>). " Loop through each entry in the legacy data table
      SPLIT to_lower( <data>-string ) AT ',' INTO TABLE DATA(letters). " Split the string of letters into individual letters using ',' as the delimiter
      LOOP AT letters ASSIGNING FIELD-SYMBOL(<letter>). " Loop through each individual letter
        DATA(n) = VALUE ty_new_data( letter = <letter> number = <data>-number ). " Create a new entry for the new data format
        INSERT n INTO TABLE new_data. " Insert the new data entry into the new data table
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
