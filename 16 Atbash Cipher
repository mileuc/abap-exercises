CLASS zcl_atbash_cipher DEFINITION " Start of the class definition for zcl_atbash_cipher
  PUBLIC " The class is publicly accessible
  FINAL  " The class cannot be inherited
  CREATE PUBLIC.   "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    "Method to decode the given cipher text using Atbash cipher"
    METHODS decode
      IMPORTING
        cipher_text TYPE string "Input cipher text to be decoded"
      RETURNING
        VALUE(plain_text)  TYPE string . "Output decoded plain text"
    
    "Method to encode the given plain text using Atbash cipher"
    METHODS encode
      IMPORTING
        plain_text        TYPE string "Input plain text to be encoded"
      RETURNING
        VALUE(cipher_text) TYPE string . "Output encoded cipher text"
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION. " Private section of the class (not used here)
ENDCLASS. " End of class definition

" Begin implementation of the class zcl_atbash_cipher
CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    "Decoding is performed by encoding the cipher text since Atbash cipher is symmetrical"
    plain_text = encode( cipher_text ).

    "Remove any spaces from the decoded plain text"
    REPLACE ALL OCCURRENCES OF ` ` IN plain_text WITH ''.

  ENDMETHOD. " End of method implementation

  METHOD encode.
    DATA output TYPE string. "Temporary string to store final output with grouped letters"
    DATA(input) = to_lower( plain_text ). "Convert input plain text to lowercase"

    "Remove spaces, periods, and commas from the input text"
    REPLACE ALL OCCURRENCES OF ` ` IN input WITH ''.
    REPLACE ALL OCCURRENCES OF '.' IN input WITH ''.
    REPLACE ALL OCCURRENCES OF ',' IN input WITH ''.

    "Loop through each character in the input"
    WHILE strlen( input ) > 0.

      "Find the position of the current character in the alphabet"
      "input(1) is used to extract the first character of the string input"
      DATA(index) = find( val = to_lower( sy-abcde ) sub = input(1) ).

      "If character is not a letter (index < 0), keep it unchanged by concatenating the unchanged character to cipher_text"
      IF index < 0.
        " && sign in ABAP is the string concatenation operator. 
        cipher_text = cipher_text && input(1).
      ELSE.
        "If character is a letter, replace it with its corresponding letter from the reversed alphabet"
        cipher_text = cipher_text && substring( val = reverse( to_lower( sy-abcde ) ) off = index len = 1 ).
      ENDIF.

      "Move to the next character in the input"
      "Means take the substring of input starting from the second character to the end. 
      "It excludes the character that was just processed, effectively reducing the length of input by 1 character for rach iteration
      input = input+1.
    ENDWHILE.

    "Group the encoded text into blocks of 5 characters, separated by spaces"
    WHILE strlen( cipher_text ) > 5.
      " The && operator concatenates the next 5 characters (cipher_text(5)) and a space (' ') to the existing output string. "
      output = output && cipher_text(5) && ` `.
      cipher_text = cipher_text+5.
    ENDWHILE.

    "Append any remaining characters to the output"
    cipher_text = output && cipher_text.
    "Concatenates the already grouped output with any remaining cipher_text."
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation

"Example to Illustrate input(1)

"Let's say the input string is "hello":

"    Initial State:
"       input = "hello"
"       input(1) = "h" (first character)

"After Processing the First Character:

    " input = input+1.
    "Now, input = "ello" (first character removed)

"Next Iteration:
        " input(1) = "e" (next character)

" This continues until the entire string is processed.
