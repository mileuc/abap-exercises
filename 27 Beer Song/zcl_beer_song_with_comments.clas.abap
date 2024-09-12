CLASS zcl_beer_song DEFINITION " Define a new class zcl_beer_song
  PUBLIC  " Class is public, so it can be accessed globally
  FINAL   " Class is final, meaning it cannot be inherited
  CREATE PUBLIC. " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside

    METHODS recite " Define a method 'recite' to generate the song lyrics
      IMPORTING " Import parameters into the method
        !initial_bottles_count TYPE i " Initial number of bottles (integer)
        !take_down_count       TYPE i " Number of verses to recite (integer)
      RETURNING " Returning parameter
        VALUE(result)          TYPE string_table. " Result is a table of strings

  PROTECTED SECTION. " Protected section (not used in this class)
  PRIVATE SECTION. " Private section (not used in this class)
ENDCLASS. " End of class definition

CLASS zcl_beer_song IMPLEMENTATION. " Begin class implementation

  METHOD recite. " Implementation of the 'recite' method

    " Use a table comprehension to create the lyrics dynamically
    result = value string_table( 
      for i = 0 then i + 1 while i lt take_down_count " Loop to generate 'take_down_count' verses
        ( cond #( " Conditional expression to determine the first line of the verse
          when ( initial_bottles_count - i ) eq 0 " When no bottles are left
          then |No more bottles of beer on the wall, no more bottles of beer.| " Last verse when no bottles remain
          when ( initial_bottles_count - i ) eq 1 " When 1 bottle is left
          then |1 bottle of beer on the wall, 1 bottle of beer.| " Verse for 1 bottle
          else |{ initial_bottles_count - i } bottles of beer on the wall, { initial_bottles_count - i } bottles of beer.| ) " General case for more than 1 bottle
        ( cond #( " Conditional expression to determine the second line of the verse
          when ( initial_bottles_count - i - 1 ) eq -1 " When bottles count goes negative
          then |Go to the store and buy some more, 99 bottles of beer on the wall.| " Last verse after all bottles are taken down
          when ( initial_bottles_count - i - 1 ) eq 0 " When 0 bottles are left after taking one down
          then |Take it down and pass it around, no more bottles of beer on the wall.| " Verse for no more bottles
          when ( initial_bottles_count - i - 1 ) eq 1 " When 1 bottle is left after taking one down
          then |Take one down and pass it around, 1 bottle of beer on the wall.| " Verse for 1 bottle remaining
          else |Take one down and pass it around, { initial_bottles_count - i - 1 } bottles of beer on the wall.| ) " General case for more than 1 bottle left
        ( || ) ). " Concatenate the first and second lines of the verse

    check result[ lines( result ) ] is initial. " Ensure the last line of the result is not empty
    delete result index lines( result ). " Delete the last empty line if it exists

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation

"First Line of the Verse: 
          " cond #(...): A conditional expression to determine the first line of each verse:
          " when ( initial_bottles_count - i ) eq 0: If no bottles are left (initial_bottles_count - i = 0), return "No more bottles of beer on the wall, no more bottles of beer."
          " when ( initial_bottles_count - i ) eq 1: If 1 bottle is left (initial_bottles_count - i = 1), return "1 bottle of beer on the wall, 1 bottle of beer."
          " else: For all other cases, return the line formatted with the remaining bottles count ({ initial_bottles_count - i })."

"( || ): Joins the two lines generated by the conditional expressions into a single entry in the result table."

" Second Line of the Verse:
        " Another conditional expression to determine the second line of the verse:
        " when ( initial_bottles_count - i - 1 ) eq -1: If the count goes negative (-1), return "Go to the store and buy some more, 99 bottles of beer on the wall."
        " when ( initial_bottles_count - i - 1 ) eq 0: If no bottles are left after taking one down, return "Take it down and pass it around, no more bottles of beer on the wall."
        " when ( initial_bottles_count - i - 1 ) eq 1: If 1 bottle is left after taking one down, return "Take one down and pass it around, 1 bottle of beer on the wall."
        " else: For all other cases, return the line formatted with the remaining bottles count ({ initial_bottles_count - i - 1 }).

" cond is a built-in ABAP construct used to create conditional expressions. It allows you to define a value based on multiple conditions, similar to an IF...ELSE statement, but in a single, compact form. The cond construct is particularly useful for dynamically setting a value based on multiple possible cases without needing to write out multiple lines of conditional logic.

" Syntax of cond
" The syntax for the cond expression is as follows:


"cond #( 
"  when <condition1> then <result1>
"  when <condition2> then <result2>
"  ...
"  else <default_result> 
")

"    cond #(...): The # sign is a shorthand for a generic data type. It infers the type from the context in which the expression is used.
"    when <condition> then <result>: Defines a condition and its corresponding result. If the condition is true, the result is returned.
"    else <default_result>: Specifies a default result to be returned if none of the preceding conditions are met.

            " check result[ lines( result ) ] is initial: Checks if the last line in the result table is empty.
    " delete result index lines( result ): If the last line is empty, it deletes it to ensure no empty line at the end of the generated lyrics."
