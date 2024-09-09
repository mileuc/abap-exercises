CLASS zcl_high_scores DEFINITION "Start of the class definition for zcl_high_Scores
  PUBLIC  "The class is publicly accessible
  FINAL   "The class cannot be inherited
  CREATE PUBLIC .   "Allows public creation of instances

  PUBLIC SECTION.
    " Define a public section where accessible methods and types are declared
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    " Define a table type 'integertab' which is a standard internal table of integers with an empty key

    METHODS constructor
      IMPORTING
        scores TYPE integertab.
      " Define a method 'constructor' that imports an internal table of integers (scores)

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.
      " Define a method 'list_scores' that returns an internal table of integers (result)

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.
      " Define a method 'latest' that returns an integer (result)

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.
      " Define a method 'personalbest' that returns an integer (result)

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
      " Define a method 'personaltopthree' that returns an internal table of integers (result)

  PROTECTED SECTION.
  " Protected section is empty, no methods or attributes accessible in this section

  PRIVATE SECTION.
    " Define a private section where internal data is declared
    DATA scores_list TYPE integertab.
    " Declare a private data attribute 'scores_list' of type 'integertab'

ENDCLASS.
  " End of class definition

CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    " Implementation of the constructor method

    scores_list = scores.
    " Assign the imported 'scores' to the private attribute 'scores_list'

  ENDMETHOD.
  " End of constructor method implementation

  METHOD list_scores.
    " Implementation of the list_scores method

    result = scores_list.
    " Return the private attribute 'scores_list' as the result

  ENDMETHOD.
  " End of list_scores method implementation

  METHOD latest.
    " Implementation of the latest method

    result = scores_list[ lines( scores_list ) ].
    " Return the last element of 'scores_list' as the result
    " 'lines( scores_list )' gives the index of the last element

  ENDMETHOD.
  " End of latest method implementation

  METHOD personalbest.
    " The personalbest method is designed to find the highest score in the scores_list."
    " Implementation of the personalbest method

    LOOP AT scores_list ASSIGNING FIELD-SYMBOL(<score>).
      " Loop through each element in 'scores_list', assigning it to <score>
      " ASSIGNING FIELD-SYMBOL(<score>): Assigns each element in scores_list to the field-symbol <score>. This allows direct manipulation of the element without creating a copy.

      IF <score> > result.
        " Check if the current score <score> is greater than the current result

        result = <score>.
        " Update result to the new highest score found
      ENDIF.
    ENDLOOP.
    " End of loop

  ENDMETHOD.
  " End of personalbest method implementation

  METHOD personaltopthree.
    " Implementation of the personaltopthree method - returns the 3 highest scores

    DATA(scores) = scores_list.
    " Copy 'scores_list' to a local variable 'scores'

    SORT scores BY table_line DESCENDING.
    " Sort 'scores' in descending order, so the highest scores come first

    LOOP AT scores ASSIGNING FIELD-SYMBOL(<score>).
      " Loop through each element in 'scores', assigning it to <score>
      " ASSIGNING FIELD-SYMBOL(<score>): Assigns each element in scores to the field-symbol <score> for direct access."

      IF sy-tabix > 3.
        " Check if the loop index sy-tabix is greater than 3

        EXIT.
        " Exit the loop if more than 3 scores have been processed
      ENDIF.

      APPEND <score> TO result.
      " Append the current score <score> to the result internal table

    ENDLOOP.
    " End of loop

  ENDMETHOD.
  " End of personaltopthree method implementation

ENDCLASS.
  " End of class implementation

" Summary
" personalbest: Finds the highest score in the list by iterating through each score and keeping track of the maximum value.

" personaltopthree: Retrieves the top three scores by sorting the scores in descending order and then collecting the first three entries into the result. 
" The loop is exited early once the top three scores are added to the result.
