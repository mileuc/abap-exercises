CLASS zcl_rna_transcription DEFINITION "Start of the class definition for zcl_rna_transcription
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    METHODS
      transcribe
      " Defines a method named transcribe which will perform the RNA transcription."
        IMPORTING
          " Transcribe method takes one input parameter strand of type string, representing the DNA strand.
          strand             TYPE string
        RETURNING
        " Method returns the result as a string, which is the RNA strand transcribed from the DNA strand.
          VALUE(result)      TYPE string.

  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION. " Reserved for defining attributes or methods that are only accessible from within the class, but currently empty.

ENDCLASS.  " End of class definition

" Begin implementation of the class zcl_rna_transcription
CLASS zcl_rna_transcription IMPLEMENTATION.
  METHOD transcribe.
    "Method named transcribe which will perform the RNA transcription.

    "Translates each character in the string strand (which represents a DNA sequence).
    " The characters GCTA are replaced with their RNA complements CGAU respectively
    "G → C
    "C → G
    "T → A
    "A → U
     result = translate( val = strand from = `GCTA` to = `CGAU` ).
  ENDMETHOD. " End of method implementation
ENDCLASS. " End of class implementation
