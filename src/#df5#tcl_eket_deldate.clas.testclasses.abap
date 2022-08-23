"!@testing /DF5/I_EKET_DELDATE
CLASS ltc_/df5/i_eket_deldate
DEFINITION FINAL FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.
  PRIVATE SECTION.

    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      "! In CLASS_SETUP, corresponding doubles and clone(s) for the CDS view under test and its dependencies are created.
      class_setup RAISING cx_static_check,
      "! In CLASS_TEARDOWN, Generated database entities (doubles & clones) should be deleted at the end of test class execution.
      class_teardown.

    DATA:
      act_results TYPE STANDARD TABLE OF /df5/i_eket_deldate WITH EMPTY KEY,
      lt_eket     TYPE STANDARD TABLE OF eket WITH EMPTY KEY.

    METHODS:
      "! SETUP method creates a common start state for each test method,
      "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
      setup RAISING cx_static_check,
      prepare_testdata_set,
      "!  In this method test data is inserted into the generated double(s) and the test is executed and
      "!  the results should be asserted with the actuals.
      closest_date_to_today_in_past FOR TESTING RAISING cx_static_check,
      closest_date_to_today_today FOR TESTING RAISING cx_static_check,
      closest_date_to_today_future FOR TESTING RAISING cx_static_check,
      closest_date_to_today_mixed FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltc_/df5/i_eket_deldate IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = '/DF5/I_EKET_DELDATE' i_select_base_dependencies = abap_true ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
    prepare_testdata_set( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD closest_date_to_today_in_past.
    SELECT * FROM /df5/i_eket_deldate ORDER BY PurchaseOrder,PurchaseOrderLine ASCENDING INTO TABLE @act_results.
    cl_abap_unit_assert=>assert_equals( exp = '20220305' act = act_results[ 1 ]-deldate ).
  ENDMETHOD.

  METHOD closest_date_to_today_today.
    SELECT * FROM /df5/i_eket_deldate ORDER BY PurchaseOrder,PurchaseOrderLine ASCENDING INTO TABLE @act_results.
    cl_abap_unit_assert=>assert_equals( exp = sy-datum act = act_results[ 2 ]-deldate ).
  ENDMETHOD.

  METHOD closest_date_to_today_future.
    SELECT * FROM /df5/i_eket_deldate ORDER BY PurchaseOrder,PurchaseOrderLine ASCENDING INTO TABLE @act_results.
    cl_abap_unit_assert=>assert_equals( exp = '20300820' act = act_results[ 3 ]-deldate ).
  ENDMETHOD.

  METHOD closest_date_to_today_mixed.
    SELECT * FROM /df5/i_eket_deldate ORDER BY PurchaseOrder,PurchaseOrderLine ASCENDING INTO TABLE @act_results.
    cl_abap_unit_assert=>assert_equals( exp = sy-datum + 10 act = act_results[ 4 ]-deldate ).
  ENDMETHOD.

  METHOD prepare_testdata_set.

    lt_eket = VALUE #(
       (
         ebeln = '1'
         ebelp = '1'
         etenr = '1'
         eindt = '20220304'
       )
       (
         ebeln = '1'
         ebelp = '1'
         etenr = '2'
         eindt = '20220305'
       )
       (
         ebeln = '1'
         ebelp = '2'
         etenr = '1'
         eindt = sy-datum
       )
       (
         ebeln = '1'
         ebelp = '2'
         etenr = '2'
         eindt = '20220820'
       )
       (
         ebeln = '1'
         ebelp = '3'
         etenr = '1'
         eindt = '20300820'
       )
       (
         ebeln = '1'
         ebelp = '3'
         etenr = '2'
         eindt = '20300825'
       )
       (
         ebeln = '1'
         ebelp = '4'
         etenr = '1'
         eindt = sy-datum + 10
       )

       (
         ebeln = '1'
         ebelp = '4'
         etenr = '2'
         eindt = '20220810'
       ) ).

    environment->insert_test_data( i_data = lt_eket ).
  ENDMETHOD.

ENDCLASS.
