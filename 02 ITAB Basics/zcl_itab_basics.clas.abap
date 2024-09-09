CLASS zcl_itab_basics DEFINITION                " Define a new class called zcl_itab_basics
  PUBLIC                                        " The class is public and can be accessed from outside
  FINAL                                         " The class is final and cannot be inherited
  CREATE PUBLIC .                               " Allow public creation of class instances


  PUBLIC SECTION.                               " Start of the public section of the class
    TYPES group TYPE c LENGTH 1.                " Define a type 'group' as a character of length 1
    TYPES: BEGIN OF initial_type,               " Begin the definition of a structured type 'initial_type' with three fields: group, number, and description
             group       TYPE group,            " Define a field 'group' of type 'group' within the structure
             number      TYPE i,                " Define a field 'number' of type integer within the structure
             description TYPE string,           " Define a field 'description' of type string within the structure
           END OF initial_type,                 " End the definition of the structured type 'initial_type'
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY. " Definition of an internal table type 'itab_data_type' with rows of type 'initial_type' and no primary key

    METHODS fill_itab                           " Declaration of a method fill_itab to fill the internal table with initial data
           RETURNING
             VALUE(initial_data) TYPE itab_data_type. " Returns a table of type 'itab_data_type'

    METHODS add_to_itab                         " Declaration of a method add_to_itab to add a record to the internal table
           IMPORTING initial_data TYPE itab_data_type  " Import parameter 'initial_data' of type 'itab_data_type'
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.   " Returns an updated table of type 'itab_data_type'

    METHODS sort_itab                           " Declaration of a method sort_itab to sort the internal table
           IMPORTING initial_data TYPE itab_data_type  " Import parameter 'initial_data' of type 'itab_data_type'
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.   " Returns a sorted table of type 'itab_data_type'

    METHODS search_itab                         " Declaration of a method search_itab to search for a specific value in the internal table
           IMPORTING initial_data TYPE itab_data_type  " Import parameter 'initial_data' of type 'itab_data_type'
           RETURNING
             VALUE(result_index) TYPE i.              " Returns an integer representing the index

  PROTECTED SECTION.                           " Protected section (not used here)
  PRIVATE SECTION.                             " Private section (not used here)
ENDCLASS.                                      " End of the class definition


" Implementation of the class methods
CLASS zcl_itab_basics IMPLEMENTATION.
  " Implementation of the method fill_itab to populate the internal table with initial data
  METHOD fill_itab.
    " Using the VALUE expression to fill the internal table 'initial_data' with 6 records
    initial_data = VALUE #( 
        ( group = 'A'	number = 10	description = 'Group A-2' ) " Record 1: Group 'A', Number 10, Description 'Group A-2'
        ( group = 'B'	number = 5	description = 'Group B'   ) " Record 2: Group 'B', Number 5, Description 'Group B'
        ( group = 'A'	number = 6	description = 'Group A-1' ) " Record 3: Group 'A', Number 6, Description 'Group A-1'
        ( group = 'C'	number = 22	description = 'Group C-1' ) " Record 4: Group 'C', Number 22, Description 'Group C-1'
        ( group = 'A'	number = 13	description = 'Group A-3' ) " Record 5: Group 'A', Number 13, Description 'Group A-3'
        ( group = 'C'	number = 500 description = 'Group C-2' ) ). " Record 6: Group 'C', Number 500, Description 'Group C-2'
  ENDMETHOD. " End of method fill_itab

  " Implementation of the method add_to_itab to add a new record to the internal table
  METHOD add_to_itab.
    " Copy the input table 'initial_data' to 'updated_data'
    updated_data = initial_data.
    " Append a new record to the internal table 'updated_data'
    APPEND VALUE #( group = 'A'	number = 19 description = 'Group A-4' ) TO updated_data.
  ENDMETHOD.  " End of method add_to_itab

  " Implementation of the method sort_itab to sort the internal table
  METHOD sort_itab.
    " Copy the input table 'initial_data' to 'updated_data'
    updated_data = initial_data.  
    " Sort the internal table 'updated_data' by 'group' in ascending order and 'number' in descending order
    SORT updated_data BY group ASCENDING number DESCENDING.
  ENDMETHOD.  " End of method sort_itab

  " Implementation of the method search_itab to find the index of a specific record
  METHOD search_itab.
    " Create a temporary copy of the internal table 'initial_data'
    DATA(temp_data) = initial_data.
    " Find the index of the first record in 'temp_data' where 'number' equals 6
    result_index = line_index( temp_data[ number = 6 ] ).
  ENDMETHOD.  " End of method search_itab

ENDCLASS.  " End of the class implementation
