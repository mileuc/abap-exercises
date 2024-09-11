CLASS zcl_matrix DEFINITION "Start of the class definition for zcl_matrix
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    " Define a type for a table of integers
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    " Method to extract a specific row from the matrix string
    METHODS matrix_row
      IMPORTING
        " The matrix string where each row is separated by a newline character
        string        TYPE string
        " The index of the row to extract (0-based index)
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.  " The table of integers representing the extracted row

    " Method to extract a specific column from the matrix string
    METHODS matrix_column
      IMPORTING
        " The matrix string where each row is separated by a newline character
        string        TYPE string
        " The index of the column to extract (0-based index)
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.  " The table of integers representing the extracted column
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)

ENDCLASS. "  End of class definition

" Begin implementation of the class zcl_matrix
CLASS zcl_matrix IMPLEMENTATION.

  " Method to extract a specific row from the matrix string
  METHOD matrix_row.
    " Split the input matrix string into individual rows based on newline characters
    SPLIT string AT '\n' INTO TABLE DATA(lines).

    " Get the specific row based on the provided index
    DATA(result_line) = lines[ index ].

    " Split the selected row into individual characters based on spaces
    SPLIT result_line AT space INTO TABLE DATA(result_chars).

    " Loop through each character in the resulting row
    LOOP AT result_chars ASSIGNING FIELD-SYMBOL(<result_char>).

      " Append each character (converted to integer) to the result table
      APPEND <result_char> TO result.

    ENDLOOP.
  ENDMETHOD.

  " Method to extract a specific column from the matrix string
  METHOD matrix_column.
    " Define a table to hold each row of the matrix as a table of strings
    DATA result_matrix TYPE TABLE OF string_table.

    " Split the input matrix string into individual rows based on newline characters
    SPLIT string AT '\n' INTO TABLE DATA(lines).

    " Loop through each row in the matrix
    LOOP AT lines ASSIGNING FIELD-SYMBOL(<line>).

      " Split each row into individual characters based on spaces
      SPLIT <line> AT space INTO TABLE DATA(result_chars).

      " Append the row of characters to the result matrix
      APPEND result_chars TO result_matrix.

    ENDLOOP.

    " Loop through each row (table of characters) in the result matrix
    LOOP AT result_matrix ASSIGNING FIELD-SYMBOL(<result_table>).

      " Loop through each character in the current row
      LOOP AT <result_table> ASSIGNING FIELD-SYMBOL(<result_value>).

        " Check if the current index matches the desired column index
        " Checks if the current row (indexed by sy-tabix) matches the desired column index."
        IF sy-tabix = index.
          " Append the character to the result table for the column
          APPEND <result_value> TO result.
        ENDIF.

      ENDLOOP.
    ENDLOOP.
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
