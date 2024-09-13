CLASS zcl_state_of_tic_tac_toe DEFINITION "Start of the class definition for zcl_state_of_tic_tac_toe
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared

    "! Define the player type ('X' or 'O')
    TYPES player_type TYPE c LENGTH 1.
    
    "! Define the board type as a table of strings (3x3 grid)
    "! Each row of the board is represented as a string, e.g., ('XOO', ' X ', '  X')
    " This line defines a new data type called board_type, which is a table of string. The table will hold strings representing the rows of a Tic-Tac-Toe board.
    " INITIAL SIZE 3 means that this table has an initial size of 3, reflecting that the Tic-Tac-Toe board has 3 rows (each row will be represented as a string)
    TYPES board_type TYPE TABLE OF string INITIAL SIZE 3.

    "! Define constants for players 'X' and 'O'
    " CONSTANTS declares a set of constant values that are grouped into a structure. 
    " 
    CONSTANTS: BEGIN OF player_enum,
                 one TYPE player_type VALUE 'X', "! Represents Player 1 in the game, who uses the symbol 'X'.
                 two TYPE player_type VALUE 'O', "! Represents Player 2 in the game, who uses the symbol 'O'.
               END OF player_enum.

    "! Define constants for game states: 'ongoing game', 'draw', and 'win'
    CONSTANTS: BEGIN OF state_enum,
                 ongoing_game TYPE string VALUE `Ongoing game`, "! Game is still ongoing
                 draw         TYPE string VALUE `Draw`,          "! Game ended in a draw
                 win          TYPE string VALUE `Win`,           "! Game ended in a win
               END OF state_enum.

    "! Method to determine the state of the game
    "! @parameter board: The current state of the board (3x3 grid)
    "! @return state: The current game state (ongoing, draw, or win)
    "! @raising cx_parameter_invalid: Raised if the board is invalid (e.g., incorrect number of moves, two winners)
    METHODS get_state
      IMPORTING board        TYPE board_type
      RETURNING VALUE(state) TYPE string
      RAISING   cx_parameter_invalid.

  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)
ENDCLASS. " End of class implementation

CLASS zcl_state_of_tic_tac_toe IMPLEMENTATION.

  "! Implementation of the get_state method to check the game's status
  METHOD get_state.

    "! Combine the 3 rows of the board into a single string 'b' for easier processing
    " This function concatenates the 3 rows of the board into a single string. If the board has rows like XOO, X, X, then b will become the string XOO X X.
    DATA(b) = concat_lines_of( table = board ). " Board offsets: 012345678

    " count(): This function counts how many occurrences of 'X' (or 'O') there are in the concatenated board b."
    "! Count how many times player 'X' appears on the board
    DATA(one) = count( val = b sub = player_enum-one ). " Stores the number of 'X' (Player 1) on the board.

    "! Count how many times player 'O' appears on the board
    DATA(two) = count( val = b sub = player_enum-two ).

    "! Validate the board:
    "! - The board must have exactly 9 characters
    "! - Only the characters 'X', 'O', or a space are allowed
    "! - The number of 'X' moves must be greater than or equal to 'O' moves but no more than one extra move
    " strlen( b ) <> 9: Checks that the board contains exactly 9 characters (3 rows of 3 characters). If it doesn't, the board is invalid.
    " b NA 'XO ': Checks that the board only contains valid characters ('X', 'O', or spaces). If it contains any other characters, the board is invalid.
    " NA means "not contains any"(negation of contains any).
    " one - two BETWEEN 0 AND 1: Checks that the number of 'X's is either equal to or one more than the number of 'O's (because Player X always starts). If this condition is violated, the board is invalid.
    IF strlen( b ) <> 9 OR b NA `XO ` OR NOT one - two BETWEEN 0 AND 1.
      RAISE EXCEPTION TYPE cx_parameter_invalid. "! Raise an exception if the board is invalid
    ENDIF.

    "! Define all the possible winning combinations (rows, columns, diagonals)
    " w: This table holds all possible winning combinations for the game.
    " Rows: 012, 345, 678
    " Columns: 036, 147, 258
    " Diagonals: 048, 246
    DATA(w) = VALUE string_table( ( `012` ) ( `345` ) ( `678` ) ( `246` ) ( `036` ) ( `147` ) ( `258` ) ( `048` ) ). " Winning combinations

    "! Set the initial state of the game as 'ongoing'
    " state: This variable will store the current state of the game. It is initially set to ongoing_game, which means the game is still in progress.
    state = state_enum-ongoing_game.

    "! Loop through each winning combination to check for a winner
    DO lines( w ) TIMES.
      "! Get the indices of the current winning combination (3 positions)
      " wi = w[ sy-index ]: For each iteration, assign the current winning combination (e.g., 012, 345, etc.) to the variable wi.
      DATA(wi) = w[ sy-index ].
      DATA(x) = CONV i( wi+0(1) ). "! First position in the winning combination
      DATA(y) = CONV i( wi+1(1) ). "! Second position in the winning combination
      DATA(z) = CONV i( wi+2(1) ). "! Third position in the winning combination

      "! Check both players ('X' and 'O') to see if either has a winning combination
      " DO 2 TIMES: This inner loop checks for both players ('X' and 'O').
      DO 2 TIMES.
        "! Set the current player to check (either 'X' or 'O')
        " p: This variable holds the current player being checked in the inner loop (either player_enum-one for 'X' or player_enum-two for 'O').
        DATA(p) = COND #( WHEN sy-index = 1 THEN player_enum-one ELSE player_enum-two ).

        "! If all three positions in the current combination belong to the same player
        " Condition checks whether the characters at positions x, y, and z in the board all match the current player p. 
        " If true, the current player p has won with this combination.
        IF b+x(1) = p AND b+y(1) = p AND b+z(1) = p.
          "! If a winner has already been found but it's a different player, the board is invalid (two winners)
          " state <> state_enum-ongoing_game:
          " This part checks if the game state has already been updated to something other than "ongoing game." This would happen if one player has already been found as the winner based on a previous winning combination.
          " state_enum-ongoing_game refers to the initial default state when no winner has been found yet. If the game is still ongoing, state will be set to state_enum-ongoing_game. But if a winning combination for one of the players has already been detected, state will be updated to reflect that.
          " state <> p:
          " This checks if the current player p (either Player 1 'X' or Player 2 'O') is different from the player who has already been identified as the winner.
          " state holds the player who has already won (either 'X' or 'O'). If another winning combination is found for a different player (i.e., p is different from state), then there would be two winners, which is not valid
          IF state <> state_enum-ongoing_game AND state <> p.
            RAISE EXCEPTION TYPE cx_parameter_invalid. "! Raise an exception if there are two winners
          ENDIF.
          "! Set the state to the current player ('X' or 'O')
          " If a winning combination is found for the player p, the state is set to the player's symbol (either 'X' or 'O').
          state = p.
        ENDIF.
      ENDDO.
    ENDDO.

    "! After checking all combinations, determine the final game state
    IF state = player_enum-one OR state = player_enum-two.
      "! If one player has won, set the state to 'win'
      state = state_enum-win.
    ELSEIF one + two = 9.
      "! If all 9 positions are filled and no one has won, set the state to 'draw'
      " If the number of 'X's and 'O's totals 9, then the board is full, and the game ends in a draw. The state is set to state_enum-draw.
      state = state_enum-draw.
    ENDIF.

  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
