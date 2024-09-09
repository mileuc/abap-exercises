" Definition of the class zcl_itab_aggregation
CLASS zcl_itab_aggregation DEFINITION
  PUBLIC                    " The class is publicly accessible
  FINAL                     " The class is final and cannot be inherited
  CREATE PUBLIC .           " The class can be instantiated publicly

  PUBLIC SECTION.           " Start of the public section

    " Definition of a single-character type named 'group'
    TYPES group TYPE c LENGTH 1.

    " Definition of a structure type 'initial_numbers_type' with two fields: group and number
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,    " Field 'group' of type 'group'
             number TYPE i,        " Field 'number' of type integer
           END OF initial_numbers_type,

           " Definition of an internal table type 'initial_numbers' to hold data of type 'initial_numbers_type'
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    " Definition of a structure type 'aggregated_data_type' to hold aggregated results
    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,   " Field 'group' of type 'group'
             count   TYPE i,       " Field 'count' of type integer for the count of records per group
             sum     TYPE i,       " Field 'sum' of type integer for the sum of numbers per group
             min     TYPE i,       " Field 'min' of type integer for the minimum value in each group
             max     TYPE i,       " Field 'max' of type integer for the maximum value in each group
             average TYPE f,       " Field 'average' of type float for the average of numbers per group
           END OF aggregated_data_type,

           " Definition of an internal table type 'aggregated_data' to hold data of type 'aggregated_data_type'
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    " Declaration of a method 'perform_aggregation' to perform the aggregation of data
    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers         " Input parameter of type 'initial_numbers'
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.        " Returns an internal table of type 'aggregated_data'

  PROTECTED SECTION.         " Protected section (not used here)
  PRIVATE SECTION.           " Private section (not used here)

ENDCLASS.                    " End of the class definition


" Implementation of the class methods
CLASS zcl_itab_aggregation IMPLEMENTATION.

* Outer Loop: Iterates over the initial_numbers table, grouping data by the group field.
* Appending Initial Line: A new line is added to aggregated_data for each group, initializing values.
* Inner Loop: Iterates over each grouped item to calculate sum, min, max values.
* Average Calculation: The average is computed for each group after processing all items in that group.

  " Implementation of the method 'perform_aggregation' to aggregate data
  METHOD perform_aggregation.

    " Loop over the internal table 'initial_numbers' and create a group for each unique 'group' value
    " REFERENCE INTO clause creates a reference initial_number pointing to the current row in the table. 
    " This reference allows efficient access to table data without copying it, optimizing memory usage.
    LOOP AT initial_numbers REFERENCE INTO DATA(initial_number)
    " GROUP BY clause groups the rows in the table based on the group field. 
    " It creates a logical grouping of rows where each group has the same value in the group field (e.g., all records with group = 'A' are grouped together).
       GROUP BY ( key = initial_number->group   " Grouping by the 'group' field
                  count = GROUP SIZE )          " 'count' is set to the size of each group
       ASCENDING                                " Sort groups in ascending order
       " Creates a reference group_key that represents the entire group. 
       " The reference allows us to access both the key of the group (the group identifier, such as 'A') and the count (the number of records in that group).
       REFERENCE INTO DATA(group_key).          " Reference to each group key

      " Initialize Aggregated Data for Each Group
      " Append an initial (empty) line to the result table 'aggregated_data' and get a reference to it
      " Creates a reference aggregated_item to the newly added row in aggregated_data. This allows us to fill the row with aggregated data for the current group.
      APPEND INITIAL LINE TO aggregated_data REFERENCE INTO DATA(aggregated_item).
      aggregated_item->group = group_key->key.  " Set the 'group' value for the aggregated item to the current group key (e.g., 'A').
      aggregated_item->count = group_key->count." Set the 'count' value for the aggregated item to the number of records in the current group.
      aggregated_item->min = 9999999.           " Initialize 'min' to a large number for comparison

      " Starts another loop, this time iterating over each record within the current group (group_key).
      " Loop over each group to aggregate the data
      " Creates a reference group_item to each record in the group. This allows us to access the numeric value (number) of each record efficiently.
      LOOP AT GROUP group_key REFERENCE INTO DATA(group_item).

        " Add the 'number' from each item in the group to the sum of the aggregated item
        " This continuously updates the running total (sum) for the current group.
        aggregated_item->sum = aggregated_item->sum + group_item->number.

        " Determine the minimum value between the current minimum and the group's number
        " Uses the nmin function to determine the minimum value between the current min (initially set to 9999999) and the number of the current record.
        " Effectively updates the min field to hold the smallest value found in the group so far.
        aggregated_item->min = nmin( val1 = aggregated_item->min
                                     val2 = group_item->number ).

        " Determine the maximum value between the current maximum and the group's number
        " Uses the nmax function to determine the maximum value between the current max (initially 0 by default) and the number of the current record.
        " Continuously updates the max field to hold the largest value found in the group.
        aggregated_item->max = nmax( val1 = aggregated_item->max
                                     val2 = group_item->number ).

      ENDLOOP.    " End of the inner loop over each group, that iterates over each group's records.

      " Calculate the average by dividing the sum by the count (the number of records in the group) 
      " Result is stored in the average field of the aggregated_item.
      aggregated_item->average = aggregated_item->sum / aggregated_item->count.

    ENDLOOP.    " End of the outer loop over all groups that iterates over all groups in the initial_numbers table.

  ENDMETHOD.   " End of the method 'perform_aggregation'

ENDCLASS.      " End of the class implementation

" Efficiency and Purpose
" The perform_aggregation method is designed to be efficient by using only one pass through the initial_numbers table.
" The use of the GROUP BY clause directly groups and aggregates the data, which means that each record is only read once. 
" This reduces the computational complexity and makes the method more efficient.

" By using internal references (REFERENCE INTO), the method avoids unnecessary copying of data, further enhancing performance and memory efficiency. 
" The method dynamically calculates all required aggregations (count, sum, min, max, and average) in a single pass, which is optimal for performance.
