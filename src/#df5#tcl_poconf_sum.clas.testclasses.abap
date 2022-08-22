"!@testing /DF5/I_POCONF_SUM
CLASS ltc_/df5/i_poconf_sum
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
      act_results           TYPE STANDARD TABLE OF /df5/i_poconf_sum WITH EMPTY KEY,
      lt_/df5/i_poconf_head TYPE STANDARD TABLE OF /df5/i_poconf_head WITH EMPTY KEY.

    METHODS:
      "! SETUP method creates a common start state for each test method,
      "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
      setup RAISING cx_static_check,
      prep_testdata_noitems,
      prep_testdata_correctsum,
      "!  In this method test data is inserted into the generated double(s) and the test is executed and
      "!  the results should be asserted with the actuals.
      overall_price_no_items FOR TESTING RAISING cx_static_check,
      overall_price_correct FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltc_/df5/i_poconf_sum IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = '/DF5/I_POCONF_SUM' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD overall_price_no_items.
    prep_testdata_noitems( ).
    SELECT * FROM /df5/i_poconf_sum INTO TABLE @act_results.
    cl_abap_unit_assert=>assert_equals( exp = 0 act = act_results[ 1 ]-totalconfirmed ).
  ENDMETHOD.

  METHOD overall_price_correct.
    prep_testdata_correctsum( ).
    SELECT * FROM /df5/i_poconf_sum INTO TABLE @act_results.
    cl_abap_unit_assert=>assert_equals( exp = 40 act = act_results[ 1 ]-totalconfirmed ).
  ENDMETHOD.

  METHOD prep_testdata_noitems.

    "Prepare test data for '/df5/i_poconf_head'
    lt_/df5/i_poconf_head = VALUE #(
      (
        ebeln = '1'
      )
      ).
    environment->insert_test_data( i_data = lt_/df5/i_poconf_head ).

  ENDMETHOD.

  METHOD prep_testdata_correctsum.

    "Prepare test data for '/df5/i_poconf_head'
    lt_/df5/i_poconf_head = VALUE #(
      (
        ebeln = '2'
        purchaseorderitem = '1'
        ekes_menge = 20
      )
      (
        ebeln = '2'
        purchaseorderitem = '1'
        ekes_menge = 20
      ) ).
    environment->insert_test_data( i_data = lt_/df5/i_poconf_head ).
  ENDMETHOD.

ENDCLASS.
