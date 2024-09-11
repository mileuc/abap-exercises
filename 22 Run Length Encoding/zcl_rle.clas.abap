CLASS zcl_rle DEFINITION "Start of the class definition for zcl_rle
  PUBLIC "The class is publicly accessible
  FINAL "The class cannot be inherited
  CREATE PUBLIC. " Defines a class named zcl_rle that is public, final (cannot be inherited), and has a public constructor

  PUBLIC SECTION. " Public section of the class where types and methods are declared

    " Method to encode a string using run-length encoding
    METHODS encode IMPORTING input TYPE string
                   RETURNING VALUE(result) TYPE string.

    " Method to decode a run-length encoded string
    METHODS decode IMPORTING input TYPE string
                   RETURNING VALUE(result) TYPE string.

ENDCLASS.

" Begin implementation of the class zcl_rle
CLASS zcl_rle IMPLEMENTATION.

  " Method to encode a string using run-length encoding
  METHOD encode.

    " Declare a variable to hold the current character being processed
    DATA character TYPE string.
    " Declare a variable to hold the sequence of duplicated characters
    DATA duplicates TYPE string.

    " Initialize remaining_string with the input string to process it
    " remaining_string: This is a variable that holds the part of the string that is yet to be processed. Initially, it is set to the entire input string."
    DATA(remaining_string) = input.

    " Loop while there are characters left in the remaining_string
    " IS NOT INITIAL: This is a condition that checks whether the variable remaining_string is not empty. 
    "In ABAP, IS INITIAL is used to determine if a variable has its initial or default value. 
    "For string variables, the initial value is an empty string (''). Therefore, IS NOT INITIAL evaluates to true if the string has any content (i.e., it is not empty)."
    " First Iteration:
    "   remaining_string = "AAABBBCCDAA".
    " The loop processes the initial portion, e.g., "AAA", and updates remaining_string to "BBBCCDAA"."
    WHILE remaining_string IS NOT INITIAL.

      " Use regular expression to find sequences of repeated characters
      " The combination [\w\s] matches any single word character or whitespace."
      " Together, (\1*) matches the sequence of the same character (including zero occurrences)."
      "(.*):
      ".*: Matches any character (.) zero or more times (*), meaning it will match the rest of the string.
      "(): Parentheses create another capturing group to capture the remainder of the string after the repeated characters. 
      FIND REGEX '([\w\s])'    " Match a single word character (A-Z, a-z, numbers, underscore) or whitespace
            && '(\1*)'        " Followed by zero or more occurrences of the same character
            && '(.*)'         " Capture the rest of the string after the repeated characters
        IN remaining_string " Searches remaining_string for patterns that match the regular expression."
        "character: Will capture the single character matched by ([\w\s]).
        "duplicates: Will capture the sequence of repeated characters matched by (\1*).
        "remaining_string: Will capture the part of the string that comes after the sequence of repeated characters matched by (.*).
        "##SUBRC_OK:
        " This is a system field (sy-subrc) that indicates whether the FIND REGEX operation was successful. ##SUBRC_OK means that the regex matched something in remaining_string."
        SUBMATCHES character duplicates remaining_string  ##SUBRC_OK. " Store matches in character, duplicates, and remaining_string
        

      " If duplicates are found, append the count and character to the result
      " This condition checks if there were any repeated characters found in the current iteration."
      " duplicates: This variable holds the sequence of repeated characters found in the current iteration. If duplicates is not empty, it means there are repeated characters."
      IF duplicates IS NOT INITIAL.
        result = |{ result }{ strlen( duplicates ) + 1 }{ character }|.
        " Append the count of duplicates plus one and the character to result
        " result: This is the string where the encoded output is being built."
        " strlen( duplicates ) + 1: This calculates the count of the repeated characters. strlen( duplicates ) gives the number of repeated characters, and adding 1 accounts for the first occurrence of the character. "
        "character: This is the character that was repeated."
      ELSE.
        result = |{ result }{ character }|.
        " Append just the character to result
        " Handles the case where no duplicates were found (i.e., the current character is not repeated). In this case, only the single character is appended to the result."
      ENDIF.

    ENDWHILE.

  ENDMETHOD.

  METHOD decode.

    " Declare a variable to hold the current character being processed
    DATA: character TYPE string,
          " Declare a variable to hold the number of repetitions
          repetitions TYPE string.

    " Initialize remaining_string with the input string to process it
    DATA(remaining_string) = input.

    " Loop while there are characters left in the remaining_string
    WHILE remaining_string IS NOT INITIAL.

      " Use regular expression to find counts and characters
      FIND REGEX '(\d*)([\w\s])(.*)' 
        IN remaining_string 
        "(\d*): This captures any sequence of digits (0 or more digits) into a group. This represents the number of repetitions for the following character. This is stored in the repetitions variable."
        "([\w\s]): This captures a single word character (A-Z, a-z, numbers, underscore) or whitespace into a group. This represents the character to be repeated. This is stored in the character variable."
        "(.*): This captures the rest of the string after the repeated character pattern into a group. This is stored in the remaining_string variable."
        "This is a status code indicating that the operation was successful. ##SUBRC_OK is used to check if the regular expression matched successfully."
        SUBMATCHES repetitions character remaining_string  ##SUBRC_OK. " Store matches in repetitions, character, and remaining_string

      " If repetitions are found, repeat the character and append to result
      " IS NOT INITIAL means that the variable has a value other than the default initial value (e.g., 0 for integers or an empty string for strings)."
      IF repetitions IS NOT INITIAL.
      " Checks if the repetitions variable contains a value. This would be true if the repetitions variable"
        " repeat( val = character occ = repetitions ): This function call repeats the character the number of times specified by repetitions.
        " val = character: The character to be repeated.
        " occ = repetitions: The number of times to repeat the character."
        result = |{ result }{ repeat( val = character occ = repetitions ) }|.
        " Append the repeated character to result
      ELSE.
        " In this case, there are no repetitions, so the character is appended directly to the result string."
        result = |{ result }{ character }|.
        " Append just the character to result
      ENDIF.

    ENDWHILE.

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
