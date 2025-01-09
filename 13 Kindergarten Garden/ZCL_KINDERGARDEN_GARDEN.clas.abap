CLASS zcl_kindergarten_garden DEFINITION "Start of the class definition for zcl_kindergarten_garten
  PUBLIC "The class is publicly accessible
  FINAL  "The class cannot be inherited
  CREATE PUBLIC. "Allows public creation of instances

  PUBLIC SECTION. " Public section of the class where types and methods are declared
    INTERFACES if_oo_adt_classrun.
    " Define a method 'plants' to determine which plants each student is responsible for.
    METHODS plants
      IMPORTING
        diagram        TYPE string " The input 'diagram' represents the garden layout as a string.
        student        TYPE string " The input 'student' represents the name of the student.
      RETURNING
        VALUE(results) TYPE string_table. " The method returns a table of plant names that the student is responsible for.

  PROTECTED SECTION. " Protected section of the class (not used here)
  PRIVATE SECTION.   " Private section of the class (not used here)

    " Define a private data attribute 'students' to hold the list of student names.
    DATA students TYPE string_table.

ENDCLASS.  " End of class definition


CLASS zcl_kindergarten_garden IMPLEMENTATION. " Begin implementation of the class zcl_kindergarten_garden

  METHOD plants.
    " Start of the method implementation plants, which calculates the plants each student is responsible for based on the garden layout and student’s name.

    " Calculate the position of the student's plants in the diagram.
    DATA(pos) = find( val = sy-abcde sub = student(1) ) * 2.
    " Using breakpoints for the above line, can confirm the value of pos is 2, meaning the index of the sy-abcde starts at 1
    " Calculates the starting position for the student's plants in the diagram based on the student's alphabetical order.
    " Find the position of the first character of the student’s name in the alphabetical order (e.g., A=1, B=2, etc.).
    " Multiply by 2 because each student has 2 plants per row.
    " find function in ABAP is used to find the position of a substring (sub) within a given string (val). It returns the position as an integer. "
    "val = sy-abcde: The val parameter specifies the string in which we want to find a substring. In this case, sy-abcde is a system field in ABAP containing the string containing the 26 letters of the alphabet "
    " sub = student(1): The sub parameter specifies the substring we are searching for within val. Here, student(1) uses the substring syntax to get the first character of the student string (i.e., the student's name)."
    " This expression will return the position of the student's first letter in the alphabetical string "ABCDE"."
    "If student is "Alice", student(1) is "A". The position of "A" in "ABCDE" is 1."
    " Since each student has 2 cups (plants) per row, we multiply the position by 2. This gives the correct starting position for the student's plants in the garden diagram."
    "For "Alice" ("A"), pos is 0 * 2 = 0. Thus, Alice's plants start at the first position in the diagram."

    " Split the 'diagram' string into individual rows based on newline characters.
    SPLIT diagram AT '\n' INTO TABLE DATA(rows).
    " Convert the multi-line garden layout into a table of rows.

    " Loop through each row in the table.
    LOOP AT rows ASSIGNING FIELD-SYMBOL(<row>).
      " Iterates over each row in the rows table, which represents the two rows of the garden diagram. "
      " Loop assigns each row to the field symbol <row> one by one."
      " For each row, process 2 plants per student.
      DO 2 TIMES.

        " Extract the plant type from the row based on the calculated position and the current index.
        " WRITE: / 'Value of sy-index:', sy-index.
        DATA(plant) = substring( val = <row> off = pos + sy-index - 1 len = 1 ).
        " DATA(syindex) = sy-index. " - Using breakpoints and debug: This confirmed that sy-index starts at 1
        " Get a single character from the row that represents the plant type.
        " This line extracts a single character (representing a plant) from the current row (<row>).
        " off = pos + sy-index - 1: The starting offset for extraction: -1 for Alice at first iteration - means starts at 0 (first char)
        " pos: The starting position calculated earlier (e.g., 0 for Alice).
        " sy-index: A system variable in ABAP that represents the current iteration number of the DO loop, starting from 0.
        " len = 1: Specifies that only one character is to be extracted.

        CASE plant.
          " Map each plant type character to its corresponding plant name.
          WHEN 'V'.
            APPEND 'violets' TO results. " Append 'violets' if the plant character is 'V'.
          WHEN 'R'.
            APPEND 'radishes' TO results. " Append 'radishes' if the plant character is 'R'.
          WHEN 'G'.
            APPEND 'grass' TO results. " Append 'grass' if the plant character is 'G'.
          WHEN 'C'.
            APPEND 'clover' TO results. " Append 'clover' if the plant character is 'C'.
        ENDCASE. " End of the CASE statement.
      ENDDO. " End of the DO loop.
    ENDLOOP. " End of the LOOP statement.

  ENDMETHOD. " End of the method implementation.

  METHOD if_oo_adt_classrun~main.
            DATA: lo_garden TYPE REF TO zcl_kindergarten_garden,
              lt_results TYPE string_table,
              lv_diagram TYPE string,
              lv_student TYPE string.

         "Initialize the garden diagram and student name.
         lv_diagram = 'VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV'.
         lv_student = 'Alice'.

         CREATE OBJECT lo_garden.

         lt_results = lo_garden->plants(
            diagram = lv_diagram
            student = lv_student
         ).

         LOOP AT lt_results INTO DATA(lv_result).
            "WRITE: / lv_result.
            out->write(  lv_result ).
          ENDLOOP.
  ENDMETHOD.
  ENDCLASS.
