CLASS zcl_isogram DEFINITION  "Start of the class definition for zcl_itab_nesting
  PUBLIC.  "The class is publicly accessible

  PUBLIC SECTION.
    "Define a method named is_isogram with one input parameter and a return value"
    METHODS is_isogram
      IMPORTING
        VALUE(phrase) TYPE string "Input string representing the word or phrase to check"
      RETURNING
        VALUE(result) TYPE abap_bool. "Output boolean indicating if the input is an isogram"
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS. " End of class definition

" Begin implementation of the class zcl_isogram
CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    "Initialize the result as true, assuming the input is an isogram until proven otherwise"
    result = abap_true.

    "Convert the input phrase to uppercase for case-insensitive comparison"
    phrase = to_upper( phrase ).

    "Initialize an offset counter to loop through each character in the phrase"
    DATA(offset) = 0.
    "Declare a table to store unique letters found in the phrase"
    DATA letters TYPE STANDARD TABLE OF string.

    "Loop through each character in the phrase"
    WHILE offset < strlen( phrase ).

      "Extract the current character from the phrase using the offset"
      "phrase: This is the input string or phrase from which we want to extract a character.
      "+offset: The + operator followed by a numeric value (offset in this case) specifies the starting position (zero-based index) within the string. This tells ABAP where to begin extracting characters.
      "(1): This specifies the length of the substring to extract, which is 1 in this case. This means we're extracting a single character starting from the position indicated by offset.
      DATA(letter) = phrase+offset(1).

      "If the current character is not an alphabetic letter, skip further checks"
      "NA: This is an ABAP operator that stands for "Not Contained In". It checks if a single character or a substring does not appear within a given set or string.
      IF letter NA sy-abcde.
        offset = offset + 1. "Increment the offset to check the next character"
        CONTINUE. "Continue to the next iteration of the loop"
      ENDIF.

      " Check if the current letter is already in the list of found letters"
      " READ TABLE: Used to search an internal table (in this case letters) for a specific entry. It attempts to locate a row in the internal table that matches the specified search criteria (i.e., a key value).
      " TRANSPORTING NO FIELDS: This addition tells the READ TABLE statement not to load the contents of the found table row into a work area or target field.
      " Optimizes performance by preventing unnecessary data movement because we're only interested in whether the row exists
      " WITH KEY table_line = letter: This specifies the search condition for the READ TABLE operation.
      " table_line is a pseudo-component that represents the entire row in the internal table letters. Since letters is defined as a table of type STANDARD TABLE OF string, each row of letters contains a single string value.
      READ TABLE letters TRANSPORTING NO FIELDS WITH KEY table_line = letter.

      "If the letter is already found in the table, set result to false and return"
      "sy-subrc is a system field that stores the return code of the last operation, such as a database read or an internal table operation. The value of sy-subrc helps determine whether the operation was successful or not.
      " 0: The operation was successful.
      " 4: No entry was found (e.g., a search or read operation didn't find the requested data).
      " 8 or higher: Other errors, such as failure to update or insert."
      IF sy-subrc = 0.
        result = abap_false. "Indicate the phrase is not an isogram"
        RETURN. "Exit the method early as a repeating letter is found"
      ENDIF.

      "If the letter is not found in the table, insert it into the table"
      INSERT phrase+offset(1) INTO TABLE letters.

      "Increment the offset to move to the next character"
      offset = offset + 1.
    ENDWHILE.

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
