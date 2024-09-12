CLASS zcl_secret_handshake DEFINITION " Define a new class 'zcl_secret_handshake'
  PUBLIC " Class is public, so it can be accessed globally
  FINAL " Class is final, meaning it cannot be inherited
  CREATE PUBLIC. " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside
    " Define a method 'get_commands' to convert a number into a sequence of secret handshake commands
    METHODS get_commands
      IMPORTING code            TYPE i " Input parameter 'code', an integer between 1 and 31
      RETURNING VALUE(commands) TYPE string_table. " Returns the resulting sequence of commands as a table of strings
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS. " End of class definition


CLASS zcl_secret_handshake IMPLEMENTATION. " Begin class implementation

  METHOD get_commands. " Implementation of the 'get_commands' method
    " Convert the input integer 'code' to a hexadecimal string
    DATA(x) = CONV xstring( code ). " Store the converted hexadecimal string in variable 'x'
    
    " Initialize a table of strings with possible secret handshake actions
    DATA(c) = VALUE string_table( ( `wink` ) ( `double blink` ) ( `close your eyes` ) ( `jump` ) ). " Handshake actions in order
    
    " Loop 4 times to check each of the lower 4 bits of the binary representation
    DO 4 TIMES. 
      " Check if the current bit position is set in the input code's binary representation
      CHECK x O CONV xstring( 2 ** ( sy-index - 1 ) ). " If the corresponding bit is set, continue; otherwise, skip to the next iteration
      " Check if the fifth bit is set to determine if the command list needs to be reversed
      IF x Z CONV xstring( 16 ). " If the fifth bit is not set
        " Insert the current command at the end of the 'commands' table
        INSERT c[ sy-index ] INTO TABLE commands.
      ELSE. " If the fifth bit is set
        " Insert the current command at the beginning of the 'commands' table to reverse order
        INSERT c[ sy-index ] INTO commands INDEX 1.
      ENDIF.
    ENDDO. " End of loop
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation

" CONV xstring( 2 ** ( sy-index - 1 ) ): This converts the result of the expression 2 ** (sy-index - 1) to a hexadecimal string (xstring)."
" 2 ** (sy-index - 1) calculates the power of 2 for the current loop index. This results in the following values across iterations:"
" For sy-index = 1: 2 ** (1 - 1) = 2 ** 0 = 1 (binary: 0001)
" For sy-index = 2: 2 ** (2 - 1) = 2 ** 1 = 2 (binary: 0010)
" For sy-index = 3: 2 ** (3 - 1) = 2 ** 2 = 4 (binary: 0100)
" For sy-index = 4: 2 ** (4 - 1) = 2 ** 3 = 8 (binary: 1000)
" x O ...: The O operator (bitwise OR comparison) checks if any of the bits in x (the hexadecimal string representation of code) overlap with the bits set in 2 ** (sy-index - 1).
" In simple terms, it checks if the specific bit position (as represented by 2 ** (sy-index - 1)) is set (1) in the binary representation of x.
" CHECK statement: This condition is used to control the flow of the loop: If the bit at the current position is not set in x, the loop moves to the next iteration (CHECK statement is false, so subsequent lines are skipped).
" If the bit is set, the CHECK statement evaluates to true, and the loop continues executing the lines that follow.

" CONV xstring( 16 ): Converts the decimal number 16 to a hexadecimal string (xstring), which represents the binary value 10000 (where the fifth bit is set).
" x Z ...: The Z operator checks if x is not equal to CONV xstring( 16 ).
" This condition checks if the fifth bit is not set in x:
    " If the fifth bit is not set, the code inserts the current command (c[sy-index]) at the end of the commands table.
    " If the fifth bit is set, the code inserts the command at the beginning of the commands table (i.e., index 1), which reverses the order of the commands.
    
" c[sy-index]: This accesses the command corresponding to the current loop index (sy-index). For example:
" sy-index = 1 => c[1] = "wink
" sy-index = 2 => c[2] = "double blink"
" sy-index = 3 => c[3] = "close your eyes"
" sy-index = 4 => c[4] = "jump"
" INSERT ... INTO TABLE commands.: This statement inserts the accessed command at the end of the commands table.

" INSERT c[ sy-index ] INTO commands INDEX 1. : This line inserts the accessed command (c[sy-index]) at the first position (INDEX 1) of the commands table.
" This effectively reverses the order of insertion when the fifth bit is set.
