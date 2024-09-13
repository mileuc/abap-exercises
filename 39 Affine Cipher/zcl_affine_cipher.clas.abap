CLASS zcl_affine_cipher DEFINITION " Start of the class definition for zcl_affine_cipher
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    TYPES: BEGIN OF key,                " Define a structure for the encryption/decryption key
             a TYPE i,                  " Integer 'a' in the affine cipher equation
             b TYPE i,                  " Integer 'b' in the affine cipher equation
           END OF key.
    CONSTANTS m TYPE i VALUE 26.        " Constant 'm' for the length of the alphabet (26 letters)
    METHODS:
      encode IMPORTING phrase        TYPE string " Method to encode a plaintext phrase
                       key           TYPE key " Encryption key of type 'key'
             RETURNING VALUE(cipher) TYPE string " Returns the encoded ciphertext
             RAISING   cx_parameter_invalid, " Exception raised if parameters are invalid
      decode IMPORTING cipher        TYPE string " Method to decode a ciphertext
                       key           TYPE key " Decryption key of type 'key'
             RETURNING VALUE(phrase) TYPE string " Returns the decoded plaintext phrase
             RAISING   cx_parameter_invalid. " Exception raised if parameters are invalid
  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
    METHODS mmi                      " Method to calculate the modular multiplicative inverse (MMI)
      IMPORTING a TYPE i             " Integer 'a' for which MMI is to be calculated
      RETURNING VALUE(mmi) TYPE i.  " Returns the MMI of 'a'
ENDCLASS.

" Begin implementation of the class zcl_affine_cipher
CLASS zcl_affine_cipher IMPLEMENTATION.
  METHOD encode.
  " Method to encode a plaintext phrase
    DATA len TYPE i.                " Variable to store the length of the ciphertext
    console=>log( |{ key-a },{ key-b }| ). " Log the key values to the console for debugging
    IF key-a MOD 2 = 0 OR key-a MOD 13 = 0. " Check if 'a' is not coprime with 26 (must not be 0 modulo 2 or 13)
      RAISE EXCEPTION TYPE cx_parameter_invalid. " Raise an exception if 'a' is invalid
    ENDIF.
    DO strlen( phrase ) TIMES.       " Loop through each character in the input phrase
      DATA(cha) = substring( val = phrase off = sy-index - 1 len = 1 ). " Extract a single character from the phrase
      DATA(pos) = find( val = to_lower( sy-abcde && '0123456789' ) sub = to_lower( cha ) ). " Find the position of the character in the alphabet
      console=>log( |\n{ sy-index }: { cha },{ pos }| ). " Log the character and its position for debugging
      IF pos >= 0.                    " Check if the character is found in the alphabet
        IF len > 0 AND len MOD 5 = 0. " Check if we need to add a space for formatting (every 5 characters)
          cipher &&= ` `.            " Add a space to the ciphertext
        ENDIF.
        IF pos < 26.                  " Check if the position is within the alphabet range
          DATA(x) = ( key-a * pos + key-b ) MOD m. " Apply the affine cipher encryption function
          cipher &&= to_lower( sy-abcde+x(1) ). " Append the encrypted character to the ciphertext
        ELSE.
          cipher &&= cha.            " Append non-alphabet characters as-is (e.g., digits)
        ENDIF.
        len += 1.                     " Increment the length counter of the ciphertext
        console=>log( |,{ x },{ cipher }| ). " Log the encrypted character and ciphertext for debugging
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD decode.
    " Method to decode a ciphertext
    DATA log TYPE string.            " Variable for logging (not used in the method)
    console=>log( |{ key-a },{ key-b }| ). " Log the key values to the console for debugging
    IF key-a MOD 2 = 0 OR key-a MOD 13 = 0. " Check if 'a' is not coprime with 26 (must not be 0 modulo 2 or 13)
      RAISE EXCEPTION TYPE cx_parameter_invalid. " Raise an exception if 'a' is invalid
    ENDIF.
    DO strlen( cipher ) TIMES.       " Loop through each character in the input ciphertext
      DATA(cha) = substring( val = cipher off = sy-index - 1 len = 1 ). " Extract a single character from the ciphertext
      DATA(pos) = find( val = to_lower( sy-abcde && '0123456789' ) sub = to_lower( cha ) ). " Find the position of the character in the alphabet
      console=>log( |\n{ sy-index }: { cha },{ pos }| ). " Log the character and its position for debugging
      IF pos >= 0.                    " Check if the character is found in the alphabet
        IF pos < 26.                  " Check if the position is within the alphabet range
          DATA(y) = ( mmi( key-a ) * ( pos - key-b ) ) MOD m. " Apply the affine cipher decryption function
          phrase &&= to_lower( sy-abcde+y(1) ). " Append the decrypted character to the plaintext
        ELSE.
          phrase &&= cha.            " Append non-alphabet characters as-is (e.g., digits)
        ENDIF.
        console=>log( |,{ y },{ phrase }| ). " Log the decrypted character and plaintext for debugging
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD mmi.
    " https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm
    DATA(t) = 0.                   " Initialize variable 't' for the Extended Euclidean Algorithm
    DATA(newt) = 1.               " Initialize variable 'newt' for the Extended Euclidean Algorithm
    DATA(r) = m.                  " Initialize variable 'r' with the constant 'm' (26)
    DATA(newr) = a.               " Initialize variable 'newr' with the input integer 'a'

    WHILE newr <> 0.              " Loop until 'newr' becomes zero
      DATA(quotient) = r DIV newr. " Calculate the quotient of 'r' divided by 'newr'
      DATA(temp) = t.            " Temporarily store the value of 't'
      t = newt.                  " Update 't' with 'newt'
      newt = temp - quotient * newt. " Update 'newt' based on the quotient and previous 'newt'
      temp = r.                  " Update 'temp' with 'r'
      r = newr.                  " Update 'r' with 'newr'
      newr = temp - quotient * newr. " Update 'newr' based on the quotient and previous 'newr'
    ENDWHILE.

    mmi = t.                     " Return 't' as the Modular Multiplicative Inverse (MMI)
  ENDMETHOD.
ENDCLASS.
