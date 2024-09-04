CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " Define a single-character type for grouping
    TYPES group TYPE c LENGTH 1.

    " Define a structure to represent initial numbers with a group identifier and number
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,       " Group identifier
             number TYPE i,           " Numeric value
           END OF initial_numbers_type,

    " Define a standard internal table to hold the initial numbers
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    " Define a structure for aggregated data with statistics
    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,    " Group identifier
             count   TYPE i,        " Count of items in the group
             sum     TYPE i,        " Sum of the numbers in the group
             min     TYPE i,        " Minimum value in the group
             max     TYPE i,        " Maximum value in the group
             average TYPE f,        " Average of the numbers in the group
           END OF aggregated_data_type,

    " Define a standard internal table to hold the aggregated data
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    " Method to perform aggregation
    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers " Table of initial numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data. " Table of aggregated results

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_itab_aggregation IMPLEMENTATION.

  METHOD perform_aggregation.
    " Loop through initial numbers, grouping by the 'group' field
    LOOP AT initial_numbers REFERENCE INTO DATA(initial_number)
       GROUP BY ( key = initial_number->group  count = GROUP SIZE )
       ASCENDING
       REFERENCE INTO DATA(group_key).

      " Initialize a new entry in the aggregated data table
      APPEND INITIAL LINE TO aggregated_data REFERENCE INTO DATA(aggregated_item).
      aggregated_item->group = group_key->key.     " Set the group identifier
      aggregated_item->count = group_key->count.   " Set the count of items
      aggregated_item->min = 9999999.              " Initialize minimum value with a large number

      " Loop through all items in the current group
      LOOP AT GROUP group_key REFERENCE INTO DATA(group_item).
        aggregated_item->sum = aggregated_item->sum + group_item->number. " Calculate the sum
        " Determine the minimum value in the group
        aggregated_item->min = nmin( val1 = aggregated_item->min
                                     val2 = group_item->number ).
        " Determine the maximum value in the group
        aggregated_item->max = nmax( val1 = aggregated_item->max
                                     val2 = group_item->number ).
      ENDLOOP.

      " Calculate the average value for the group
      aggregated_item->average = aggregated_item->sum / aggregated_item->count.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
