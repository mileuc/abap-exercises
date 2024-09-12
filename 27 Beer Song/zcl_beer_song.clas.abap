CLASS zcl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_beer_song IMPLEMENTATION.

  METHOD recite.

    result = value string_table( for i = 0 then i + 1 while i lt take_down_count
           ( cond #(
               when ( initial_bottles_count - i ) eq 0
               then |No more bottles of beer on the wall, no more bottles of beer.|
               when ( initial_bottles_count - i ) eq 1
               then |1 bottle of beer on the wall, 1 bottle of beer.|
               else |{ initial_bottles_count - i } bottles of beer on the wall, { initial_bottles_count - i } bottles of beer.| ) )
           ( cond #(
               when ( initial_bottles_count - i - 1 ) eq -1
               then |Go to the store and buy some more, 99 bottles of beer on the wall.|
               when ( initial_bottles_count - i - 1 ) eq 0
               then |Take it down and pass it around, no more bottles of beer on the wall.|
               when ( initial_bottles_count - i - 1 ) eq 1
               then |Take one down and pass it around, 1 bottle of beer on the wall.|
               else |Take one down and pass it around, { initial_bottles_count - i - 1 } bottles of beer on the wall.| ) )
           ( || ) ).

check result[ lines( result ) ] is initial.
delete result index lines( result ).

  ENDMETHOD.

ENDCLASS.
