CLASS zcl_elyses_enchantments DEFINITION " Define a new class 'zcl_elyses_enchantments'
  PUBLIC " Class is public, so it can be accessed globally
  FINAL " Class is final, meaning it cannot be inherited
  CREATE PUBLIC. " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside

    " Define a type for the stack, which is a standard table of integers with an empty key
    TYPES ty_stack TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    "! Define a method to get a card at a specific position in the stack
    METHODS get_item
      IMPORTING stack         TYPE ty_stack " Input stack of cards
                position      TYPE i " Position of the card to retrieve
      RETURNING VALUE(result) TYPE i. " Returns the card at the given position

    "! Define a method to replace a card at a specific position in the stack
    METHODS set_item
      IMPORTING stack         TYPE ty_stack " Input stack of cards
                position      TYPE i " Position of the card to replace
                replacement   TYPE i " Replacement card value
      RETURNING VALUE(result) TYPE ty_stack. " Returns the updated stack

    " Define a method to insert a new card at the top of the stack
    METHODS insert_item_at_top
      IMPORTING stack         TYPE ty_stack " Input stack of cards
                new_card      TYPE i " New card to insert at the top
      RETURNING VALUE(result) TYPE ty_stack. " Returns the updated stack

    "! Define a method to remove a card at a specific position in the stack
    METHODS remove_item
      IMPORTING stack         TYPE ty_stack " Input stack of cards
                position      TYPE i " Position of the card to remove
      RETURNING VALUE(result) TYPE ty_stack. " Returns the updated stack

    "! Define a method to remove the top card from the stack
    METHODS remove_item_from_top
      IMPORTING stack         TYPE ty_stack " Input stack of cards
      RETURNING VALUE(result) TYPE ty_stack. " Returns the updated stack

    "! Define a method to insert a new card at the bottom of the stack
    METHODS insert_item_at_bottom
      IMPORTING stack         TYPE ty_stack " Input stack of cards
                new_card      TYPE i " New card to insert at the bottom
      RETURNING VALUE(result) TYPE ty_stack. " Returns the updated stack

    "! Define a method to remove the bottom card from the stack
    METHODS remove_item_from_bottom
      IMPORTING stack         TYPE ty_stack " Input stack of cards
      RETURNING VALUE(result) TYPE ty_stack. " Returns the updated stack

    "! Define a method to get the size of the stack
    METHODS get_size_of_stack
      IMPORTING stack         TYPE ty_stack " Input stack of cards
      RETURNING VALUE(result) TYPE i. " Returns the size of the stack

  PROTECTED SECTION. " Protected section (not used in this class)
  PRIVATE SECTION. " Private section (not used in this class)
ENDCLASS. " End of class definition


CLASS zcl_elyses_enchantments IMPLEMENTATION. " Begin class implementation

  METHOD get_item. " Implementation of the 'get_item' method
    result = stack[ position ]. " Retrieve the card at the specified position from the stack
  ENDMETHOD. " End of method implementation


  METHOD set_item. " Implementation of the 'set_item' method
    result = stack. " Initialize result with the input stack
    MODIFY result INDEX position FROM replacement. " Replace the card at the given position with the replacement card
  ENDMETHOD. " End of method implementation


  METHOD insert_item_at_top. " Implementation of the 'insert_item_at_top' method
    result = stack. " Initialize result with the input stack
    APPEND new_card TO result. " Append the new card to the top (end) of the stack
  ENDMETHOD. " End of method implementation


  METHOD get_size_of_stack. " Implementation of the 'get_size_of_stack' method
    result = lines( stack ). " Calculate the number of cards (rows) in the stack
  ENDMETHOD. " End of method implementation


  METHOD insert_item_at_bottom. " Implementation of the 'insert_item_at_bottom' method
    result = stack. " Initialize result with the input stack
    INSERT new_card INTO result INDEX 1. " Insert the new card at the bottom (beginning) of the stack
  ENDMETHOD. " End of method implementation


  METHOD remove_item. " Implementation of the 'remove_item' method
    result = stack. " Initialize result with the input stack
    DELETE result INDEX position. " Remove the card at the specified position from the stack
  ENDMETHOD. " End of method implementation


  METHOD remove_item_from_bottom. " Implementation of the 'remove_item_from_bottom' method
    result = stack. " Initialize result with the input stack
    DELETE result INDEX 1. " Remove the card from the bottom (first row) of the stack
  ENDMETHOD. " End of method implementation


  METHOD remove_item_from_top. " Implementation of the 'remove_item_from_top' method
    result = stack. " Initialize result with the input stack
    DELETE result INDEX lines( stack ). " Remove the card from the top (last row) of the stack
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
