CLASS zcl_itab_basics DEFINITION                " Define a new class called zcl_itab_basics
  PUBLIC                                        " Class visibility is public
  FINAL                                         " Class cannot be inherited
  CREATE PUBLIC .                               " Allow public creation of class instances

  PUBLIC SECTION.                               " Public section of the class
    TYPES group TYPE c LENGTH 1.                " Define a type 'group' as a character of length 1
    TYPES: BEGIN OF initial_type,               " Begin the definition of a structured type 'initial_type'
             group       TYPE group,            " Define a field 'group' of type 'group' within the structure
             number      TYPE i,                " Define a field 'number' of type integer within the structure
             description TYPE string,           " Define a field 'description' of type string within the structure
           END OF initial_type,                 " End the definition of the structured type 'initial_type'
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY. " Define a table type 'itab_data_type' as a standard table of 'initial_type' with an empty key

    METHODS fill_itab                           " Define a method 'fill_itab' that returns an internal table
           RETURNING
             VALUE(initial_data) TYPE itab_data_type. " Return value of type 'itab_data_type'

    METHODS add_to_itab                         " Define a method 'add_to_itab' that adds a record to an internal table
           IMPORTING initial_data TYPE itab_data_type  " Import parameter 'initial_data' of type 'itab_data_type'
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.   " Return value 'updated_data' of type 'itab_data_type'

    METHODS sort_itab                           " Define a method 'sort_itab' that sorts the internal table
           IMPORTING initial_data TYPE itab_data_type  " Import parameter 'initial_data' of type 'itab_data_type'
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.   " Return value 'updated_data' of type 'itab_data_type'

    METHODS search_itab                         " Define a method 'search_itab' to search for a value in the internal table
           IMPORTING initial_data TYPE itab_data_type  " Import parameter 'initial_data' of type 'itab_data_type'
           RETURNING
             VALUE(result_index) TYPE i.              " Return value 'result_index' of type integer

  PROTECTED SECTION.                           " Protected section (currently empty)
  PRIVATE SECTION.                             " Private section (currently empty)
ENDCLASS.                                       " End of class definition

CLASS zcl_itab_basics IMPLEMENTATION.           " Start of the class implementation

  METHOD fill_itab.                             " Start method 'fill_itab'
    " Create temporary internal table lt_data
    DATA: lt_data TYPE itab_data_type.          " Define a local internal table 'lt_data' of type 'itab_data_type'

    " Populate internal table with the given records
    APPEND VALUE #( group = 'A' number = 10 description = 'Group A-2') TO lt_data. " Add a record to lt_data
    APPEND VALUE #( group = 'B' number = 5 description = 'Group B') TO lt_data.    " Add a record to lt_data
    APPEND VALUE #( group = 'A' number = 6 description = 'Group A-1') TO lt_data.  " Add a record to lt_data
    APPEND VALUE #( group = 'C' number = 22 description = 'Group C-1') TO lt_data. " Add a record to lt_data
    APPEND VALUE #( group = 'A' number = 13 description = 'Group A-3') TO lt_data. " Add a record to lt_data
    APPEND VALUE #( group = 'C' number = 500 description = 'Group C-2') TO lt_data. " Add a record to lt_data

    " Assign lt_data to internal table initial_data
    initial_data = lt_data.                     " Assign the populated 'lt_data' to the output parameter 'initial_data'
  ENDMETHOD.                                    " End method 'fill_itab'

  METHOD add_to_itab.                           " Start method 'add_to_itab'
    updated_data = initial_data.                " Initialize 'updated_data' with the contents of 'initial_data'
    
    " Add new record to the table
    APPEND VALUE #( group = 'A' number = 19 description = 'Group A-4' ) TO updated_data. " Add a new record to 'updated_data'
  ENDMETHOD.                                    " End method 'add_to_itab'

  METHOD sort_itab.                             " Start method 'sort_itab'
    " Sort the internal table first by GROUP in alphabetical order and then by NUMBER in descending order
    SORT initial_data BY group ASCENDING number DESCENDING. " Sort 'initial_data' by 'group' ascending and 'number' descending
    updated_data = initial_data.                " Assign the sorted 'initial_data' to 'updated_data'
  ENDMETHOD.                                    " End method 'sort_itab'

  METHOD search_itab.                           " Start method 'search_itab'
    " lv_index is Local Variable for Index to keep track of the current position in an internal table
    DATA: lv_index TYPE i VALUE 0.              " Define local variable 'lv_index' of type integer initialized to 0

    " Find index of the record where the NUMBER column has a value of 6
    LOOP AT initial_data INTO DATA(current_row) WHERE number = 6.  " Loop through 'initial_data' to find a record with 'number' = 6
      lv_index = sy-tabix.                      " Assign the current index to 'lv_index'
      EXIT.                                     " Exit the loop after finding the record
    ENDLOOP.                                    " End of loop

    result_index = lv_index.                    " Assign 'lv_index' to 'result_index' to return the found index
  ENDMETHOD.                                    " End method 'search_itab'

ENDCLASS.                                       " End of class implementation
