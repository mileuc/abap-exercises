CLASS zcl_crypto_square DEFINITION " Start of the class definition for zcl_crypto_square
  PUBLIC " The class is publicly accessible
  FINAL  " The class cannot be inherited
  CREATE PUBLIC. " Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    "! Method to encode a plain text using square code
    METHODS encode IMPORTING plain_text         TYPE string
                   RETURNING VALUE(crypto_text) TYPE string.
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.            " End of class definition

" Begin implementation of the class zcl_crypto_square
CLASS zcl_crypto_square IMPLEMENTATION.
  METHOD encode.
    "! Convert input plain text to lowercase and remove non-alphanumeric characters
    " Converts the entire string to lowercase using to_lower().
    " Removes all characters that are not alphanumeric (i.e., removes spaces and punctuation) using a regular expression (regex = '[^a-z0-9]').
    " This leaves only lowercase letters and digits in the text variable.
    DATA(text) = replace( val = to_lower( plain_text ) regex = '[^a-z0-9]' with = '' occ = 0 ).

    "! Ensure that text is not empty after cleaning it
    " If the text is empty, the method stops.
    CHECK text IS NOT INITIAL.

    "! Calculate the number of columns needed in the square (rounded up sqrt of text length)
    " The number of columns (cols) is calculated by taking the ceiling (ceil()) of the square root of the text's length. This ensures that the columns form the smallest possible rectangle that fits the text.
    DATA(cols) = CONV i( ceil( sqrt( strlen( text ) ) ) ).

    "! Calculate the number of rows based on the square's dimension (rounded sqrt of text length)
    "The number of rows (rows) is calculated by rounding the square root of the text's length (round()), ensuring the rows and columns match the size constraints for the crypto square.
    DATA(rows) = CONV i( round( val = sqrt( strlen( text ) ) dec = 0 ) ).

    "! Loop over the number of columns to create the encoded message
    DO cols TIMES.
      " The loop processes each column, and the index is used to extract the respective characters.
      "! Column index, zero-based for positioning within the text
      " The col variable is initialized as sy-index - 1, which gives the zero-based column index for character extraction.
      DATA(col) = sy-index - 1.

      "! Loop over each row to collect the characters in the current column
      DO rows TIMES.
        "! Calculate the character position (offset) within the original text based on row and column
        " This allows the method to collect characters down each column.
        " The offset is the calculated index used to pick characters from the text
        " Offset represents the position of the current character in the normalized text (text), based on the current row (sy-index - 1) and column (col). 
        " This logic ensures that the method picks characters vertically, column by column.
        DATA(offset) = ( sy-index - 1 ) * cols + col.

        "! Check if the calculated offset is within the length of the text
        IF offset < strlen( text ).
          "! Append the character at the calculated position to the encoded text
          " The character at the given offset is appended to crypto_text.
          crypto_text &&= text+offset(1). 
        ELSE.
          "! If there's no character at the current offset, append a space to the encoded text
          " A space ( ) is added to the crypto_text to pad the square, ensuring even chunks of data.
          crypto_text &&= ` `.
        ENDIF.
      ENDDO.

      "! After each column, check if additional spaces are required (padding the last chunk)
      " The IF condition checks if the current chunk needs to be separated by a space. This ensures that the output is formatted into properly spaced blocks. If there is still space left in the encoded text, an additional space is appended between blocks of characters.
      " offset + 1: This represents the next character's position in the flattened grid (because offset is zero-based, adding 1 gives a one-based position).
      " This is the total number of slots in the rectangular grid of text, calculated as the product of the number of columns and rows. It gives the total number of spaces that the text (or spaces) can occupy. It’s also the maximum length of the fully encoded message with padding.
      " IF offset + 1 < cols * rows: This condition checks if there are still more characters or slots left to fill. The offset + 1 represents the current position in a one-based index, and cols * rows represents the total available positions. If the current position is less than the total grid size (cols * rows), it means there are more chunks of text to follow, so a space needs to be added to separate them.
      " Once the method has processed all characters and filled the grid (offset + 1 >= cols * rows), it stops adding spaces. 
      IF offset + 1 < cols * rows.
        "! Append a space to separate each column group
        crypto_text &&= ` `.
      ENDIF.
    ENDDO.
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
