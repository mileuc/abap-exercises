CLASS zcl_nth_prime DEFINITION   "Start of the class definition for zcl_nth_prime  
  PUBLIC          "The class is publicly accessible
  FINAL           "The class cannot be inherited
  CREATE PUBLIC . "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    "Define a method named prime with one input parameter and a return value"
    METHODS prime
      IMPORTING
        input         TYPE i "Input integer representing the nth prime number to find"
      RETURNING
        VALUE(result) TYPE i "Output integer representing the nth prime number"
      RAISING
        cx_parameter_invalid. "Exception to be raised if input is invalid (e.g., 0)"
  PROTECTED SECTION.  " Protected section of the class (not used here)
  PRIVATE SECTION.    " Private section of the class (not used here)

ENDCLASS.             " End of class definition

" Begin implementation of the class zcl_nth_prime
CLASS zcl_nth_prime IMPLEMENTATION.
  METHOD prime.
    "Check if the input is 0, which is an invalid case"
    IF input = 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid. "Raise exception if input is 0"
    ENDIF.

    "Declare a table to hold integers from 2 to n^2 for prime number generation"
    DATA int_list TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    "Declare a table to store the filtered list of prime numbers"
    DATA int_list_result TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    "Declare variable to hold the maximum limit for prime number search"
    DATA max TYPE int8.
    "Declare a variable to keep track of the current prime number"
    DATA prime_number TYPE int8.
    "Compute the upper bound for generating prime numbers as n * n"
    DATA(times) = input * input.
    
    "Ensure times is at least 2 for a valid prime search range"
    IF times <= 1.
      times = 2.
    ENDIF.

    "Fill the int_list table with numbers from 2^0 to n^2"
    DO times TIMES.
      APPEND sy-tabix + 1 TO int_list. "Append numbers to int_list table"
    ENDDO.

    "Remove the first element (which is the number 1) since it is not a prime number"
    DELETE int_list INDEX 1.

    "Copy the initial list of integers to int_list_result for processing"
    int_list_result = int_list.

    "Start checking for prime numbers from 2"
    prime_number = 2.

    "Set the maximum number to check for prime generation"
    max = input * input.

    "Continue the sieve process while the square of the prime number is less than max"
    "The code uses a variation of the Sieve of Eratosthenes algorithm to filter out non-prime numbers.
    "It checks each number in int_list and removes those that are divisible by the current prime_number but are not equal to prime_number"
    WHILE prime_number * prime_number < max.

      "Loop through each integer in the int_list"
      LOOP AT int_list ASSIGNING FIELD-SYMBOL(<integer>).
        "Check if the current integer is divisible by prime_number but is not prime_number itself"
        IF <integer> MOD prime_number = 0 AND <integer> <> prime_number.
          "Remove the number from int_list_result if it is not a prime"
          DELETE int_list_result WHERE table_line = <integer>.
        ENDIF.
      ENDLOOP.

      "Increment prime_number to the next integer to continue checking"
      prime_number = prime_number + 1.
    ENDWHILE.

    "Retrieve the nth prime number from the filtered list"
    result = int_list_result[ input ].
  ENDMETHOD. " End of method implementation

ENDCLASS. " End of class implementation
