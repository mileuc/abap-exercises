CLASS zcl_acronym DEFINITION " Define a new class 'zcl_acronym'
  PUBLIC " Class is public, so it can be accessed globally
  FINAL " Class is final, meaning it cannot be inherited
  CREATE PUBLIC . " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside
    "! Method to parse a given phrase and convert it into an acronym
    METHODS parse IMPORTING phrase         TYPE string      " Input parameter: the phrase to convert to an acronym
                  RETURNING VALUE(acronym) TYPE string.     " Output parameter: the generated acronym
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS.           " End of class definition

" Begin implementation of the class zcl_acronym
CLASS zcl_acronym IMPLEMENTATION.

  "! Implementation of the method to generate an acronym from a given phrase
  METHOD parse.
    "! Replace hyphens, underscores, and extra spaces with spaces in the input phrase
    TRANSLATE phrase USING '- _ '.  
    
    "! Remove any multiple spaces and split the phrase into individual words at each space
    " condense( phrase ) removes any leading, trailing, and multiple spaces from the phrase.
    " SPLIT ... AT ' ' splits the phrase into words wherever there is a single space.
    " INTO TABLE DATA(words) stores the resulting words into an internal table words.
    SPLIT condense( phrase ) AT ' ' INTO TABLE DATA(words).  
    
    "! Loop through each word in the resulting table of words
    " Loops through each word in the table words and assigns each word to the field-symbol <word>.
    LOOP AT words ASSIGNING FIELD-SYMBOL(<word>).  
    
      "! Append the first letter of each word (in uppercase) to the acronym
      " to_upper( <word>(1) ) converts the first character of each word to uppercase.
      " acronym &&= appends the uppercase first character of each word to the acronym string.
      acronym &&= to_upper( <word>(1) ).  
    
    ENDLOOP.  "! End of loop for processing all words

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
