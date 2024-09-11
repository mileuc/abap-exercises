CLASS zcl_minesweeper DEFINITION "Start of the class definition for zcl_minesweeper
  PUBLIC  "The class is publicly accessible
  FINAL   "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared

    METHODS annotate
      "Takes a matrix of strings as input and returns a matrix of strings with mine counts.
        IMPORTING
          !input        TYPE string_table " Input matrix of strings where each string represents a row of the board
        RETURNING
          VALUE(result) TYPE string_table. " Output matrix with mine counts annotated in place of empty spaces

ENDCLASS.

" Begin implementation of the class zcl_minesweeper
CLASS zcl_minesweeper IMPLEMENTATION.

  "Takes a matrix of strings as input and returns a matrix of strings with mine counts.
  METHOD annotate.
    " Initializes the result matrix with the same content as the input matrix.
    result = input[].

    " Loop through each row of the input matrix
    LOOP AT input INTO DATA(lv_row).
      " Get the current row index
      DATA(lv_rowindex) = sy-tabix.
      
      " Get the width (length) of the current row
      DATA(lv_width) = strlen(lv_row).
      
      " Initialize column index for processing each character in the row
      DATA(lv_colindex) = 0.
      
      " Loop through each character in the row
      DO lv_width TIMES.
        " Get the character at the current column index
        DATA(lv_char) = lv_row+lv_colindex(1).

        " If the character is a mine, update adjacent cells
        IF lv_char = '*'.
          " Set the row index to update surrounding cells
          " Represents the row index of the surrounding cells that need to be updated when a mine is found in the current cell.
          DATA(row_to_update) = lv_rowindex - 1.

          " Loop through the rows above, current row, and below
          DO 3 TIMES.
            " Check if the row index is within the bounds of the result matrix
            " lines(result) is a function that returns the number of rows in an internal table."
            IF row_to_update > 0 AND row_to_update <= lines(result).
              " Assign the row to a field symbol for modification
              ASSIGN result[row_to_update] TO FIELD-SYMBOL(<fs>).

              " Set the column index to update surrounding cells
              " Represents the column index of the surrounding cells that need to be updated when a mine is found in the current cell."
              DATA(col_to_update) = lv_colindex - 1.

              " Loop through the columns to the left, current column, and right
              DO 3 TIMES.
                " Check if the column index is within bounds
                IF col_to_update > -1 AND col_to_update < lv_width.
                  " Get the character at the current column index in the field symbol
                  DATA(lv_char_to_update) = <fs>+col_to_update(1).
                  
                  " If the character is not a mine
                  IF lv_char_to_update <> '*'.
                    " If the character is an empty space
                    IF lv_char_to_update = ` `.
                      " Set the character to '1'
                      lv_char_to_update = '1'.
                    ELSE.
                      " Otherwise, increment the count of adjacent mines
                      DATA(cnt TYPE I).
                      WRITE lv_char_to_update TO cnt.
                      cnt += 1.
                      WRITE cnt TO lv_char_to_update.
                    ENDIF.
                    " Update the field symbol with the new character
                    <fs> = SUBSTRING(VAL = <fs> OFF = 0 LEN = col_to_update ) &&
                      lv_char_to_update &&
                      SUBSTRING(VAL = <fs> OFF = col_to_update + 1 ).
                  ENDIF.
                ENDIF.
                " Move to the next column
                col_to_update += 1.
              ENDDO.
            ENDIF.
            " Move to the next row
            row_to_update += 1.
          ENDDO.
        ENDIF.
        
        " Move to the next column
        lv_colindex += 1.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
