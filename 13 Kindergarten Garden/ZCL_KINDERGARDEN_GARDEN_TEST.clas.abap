CLASS zcl_kindergarten_garden_test DEFINITION PUBLIC FINAL CREATE PUBLIC.
    PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_kindergarten_garden_test IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
        DATA: lo_garden TYPE REF TO zcl_kindergarten_garden,
              lt_results TYPE string_table,
              lv_diagram TYPE string,
              lv_student TYPE string.

         "Initialize the garden diagram and student name.
         lv_diagram = 'VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV'.
         lv_student = 'Bruce'.

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
