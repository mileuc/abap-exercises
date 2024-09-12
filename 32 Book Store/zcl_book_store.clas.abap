CLASS zcl_book_store DEFINITION " Define a new class 'zcl_book_store'
  PUBLIC " Class is public, so it can be accessed globally
  FINAL " Class is final, meaning it cannot be inherited
  CREATE PUBLIC . " Class can be instantiated publicly

  PUBLIC SECTION. " Public section of the class, accessible from outside

    "! Define a type to represent the ID of a book (from 1 to 5)
    TYPES book_id TYPE i.  

    "! Define a table type to represent a sorted basket of book IDs
    TYPES basket_type TYPE SORTED TABLE OF book_id WITH NON-UNIQUE KEY table_line.

    "! Define a type for the total cost, as a packed number with 3 digits and 2 decimal places
    TYPES total TYPE p LENGTH 3 DECIMALS 2.  

    "! Method to calculate the total price of books in the basket, applying maximum discounts
    "! @parameter basket | A sorted table representing the basket of books (e.g., ( ( 1 ) ( 1 ) ( 2 ) ))
    "! @return total | The total cost after applying the best possible discounts
    METHODS calculate_total
      IMPORTING
        basket       TYPE basket_type  " Input parameter: table of book IDs representing books purchased
      RETURNING
        VALUE(total) TYPE total.  " Output parameter: final total cost after discounts

  PROTECTED SECTION.
  PRIVATE SECTION.

    "! Define a constant representing the fixed price of a single book
    CONSTANTS price_per_book TYPE i VALUE 8.  

    TYPES:
      "! Define a structure to store the count of each book type
      BEGIN OF ty_count,
        book  TYPE book_id,  " Field to store the book ID
        count TYPE i,  " Field to store the count of books of this type
      END OF ty_count,
      "! Define a table type for holding counts of each book, using the book ID as a key
      ty_counts TYPE TABLE OF ty_count WITH KEY book.  

    TYPES:
      "! Define a structure to store the discount details based on the number of different books
      BEGIN OF ty_discount,
        books  TYPE i,  " Number of different books in a group for a specific discount
        amount TYPE total,  " Discount multiplier for that group
      END OF ty_discount,
      "! Define a table type for holding all possible discount rules, keyed by the number of different books
      ty_discounts TYPE TABLE OF ty_discount WITH KEY books.  

ENDCLASS.

CLASS zcl_book_store IMPLEMENTATION.

"! Method to calculate the total cost of books in the basket, applying the maximum possible discounts
METHOD calculate_total.

    "! Declare a variable to store the cost for the current combination of books
    DATA costs TYPE total.  

    "! Initialize the discount rules with the percentage discount for different combinations of book groups
    DATA(discounts) = VALUE ty_discounts(
      ( books = 5 amount = '0.75' )  " 25% discount for a group of 5 different books
      ( books = 4 amount = '0.80' )  " 20% discount for a group of 4 different books
      ( books = 3 amount = '0.90' )  " 10% discount for a group of 3 different books
      ( books = 2 amount = '0.95' )  " 5% discount for a group of 2 different books
      ( books = 1 amount = '1.00' ) ).  " No discount for a single book

    "! Initialize 'total' to a high value to ensure it will be minimized during calculations
    total = 999.  

    "! Initialize a counter to track the count of each book in the basket
    DATA(counter) = VALUE ty_counts(
      ( book = 1 )  " Initialize the count for book ID 1
      ( book = 2 )  " Initialize the count for book ID 2
      ( book = 3 )  " Initialize the count for book ID 3
      ( book = 4 )  " Initialize the count for book ID 4
      ( book = 5 ) ).  " Initialize the count for book ID 5

    "! Loop through each book in the basket to count the total number of each type
    LOOP AT basket INTO DATA(book).  
      counter[ book = book ]-count += 1.  " Increment the count for the corresponding book ID in the counter
    ENDLOOP.

    "! Start with the maximum group size (5 different books) and decrease down to 1
    DATA(size) = 5.  
    WHILE size > 0.  

      "! Copy the current counts of books to a temporary variable for processing
      DATA(volumes) = counter.  
      "! Reset the current cost to 0 for each iteration of group size
      costs = 0.  

      "! Loop through all discount levels applicable to the current group size
      LOOP AT discounts INTO DATA(discount) WHERE books <= size.  
        DO.  " Inner loop to apply discounts based on different combinations
          "! Initialize a counter for the number of different books remaining
          DATA(remaining_books) = 0.  
          "! Count the number of book types still available in the volumes table
          LOOP AT volumes INTO DATA(volume) WHERE count > 0.  
            remaining_books += 1.  " Increment the count of remaining book types
          ENDLOOP.
          "! If there are not enough different books to apply the current discount, exit the loop
          IF remaining_books < discount-books.  
            EXIT.  
          ENDIF.

          "! Sort the books in descending order by count to apply the largest group discount first
          SORT volumes BY count DESCENDING.  
          "! Reduce the count of books for the current discount group
          DO discount-books TIMES.  
            volumes[ sy-index ]-count -= 1.  " Decrement the count of the book at the current index in volumes
          ENDDO.

          "! Add the cost of the current group after applying the discount
          costs += price_per_book * discount-books * discount-amount.  
        ENDDO.  " End of the inner loop for applying discounts
      ENDLOOP.  " End of the loop through applicable discounts

      "! Update the total cost to the minimum value between the current total and the new costs
      total = nmin( val1 = total val2 = costs ).  
      "! Decrease the group size by 1 to consider smaller groups in the next iteration
      size -= 1.  

    ENDWHILE.  " End of the loop for trying different group sizes

  ENDMETHOD.
ENDCLASS.
