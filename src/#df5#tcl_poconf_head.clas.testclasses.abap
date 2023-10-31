"!@testing /DF5/I_POCONF_HEAD
CLASS ltc_/df5/i_poconf_head
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
      act_results            TYPE STANDARD TABLE OF /df5/i_poconf_head WITH EMPTY KEY,
      lt_/df5/i_ekko         TYPE STANDARD TABLE OF /df5/i_ekko WITH EMPTY KEY,
      lt_/df5/i_poconf_items TYPE STANDARD TABLE OF /df5/i_poconf_items WITH EMPTY KEY,
      lt_i_supplier          TYPE STANDARD TABLE OF i_supplier WITH EMPTY KEY.

    METHODS:
      "! SETUP method creates a common start state for each test method,
      "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
      setup RAISING cx_static_check,
      prepare_testdata_set,
      "!  In this method test data is inserted into the generated double(s) and the test is executed and
      "!  the results should be asserted with the actuals.
      aunit_for_cds_method FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltc_/df5/i_poconf_head IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = '/DF5/I_POCONF_HEAD' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD aunit_for_cds_method.
    prepare_testdata_set( ).
    SELECT * FROM /df5/i_poconf_head INTO TABLE @act_results.
    cl_abap_unit_assert=>fail( msg = 'Place your assertions here' ).
  ENDMETHOD.

  METHOD prepare_testdata_set.

    "Prepare test data for '/df5/i_ekko'
    lt_/df5/i_ekko = VALUE #(
      (
        ebeln = '4500000006'
        bukrs = '1010'
        bstyp = 'F'
        bsart = 'NB'
        statu = '9'
        aedat = '20220224'
        ernam = 'VERHAEGHENR'
        lastchangedatetime = '20220224093824.6316610 '
        pincr = '00010'
        lponr = '00010'
        lifnr = '0010300006'
        spras = 'D'
        zterm = '0001'
        zbd1t = '0 '
        zbd2t = '0 '
        zbd3t = '0 '
        zbd1p = '0.000 '
        zbd2p = '0.000 '
        ekorg = '1010'
        ekgrp = '001'
        waers = 'EUR'
        wkurs = '1.00000 '
        bedat = '20220224'
        kdatb = '00000000'
        kdate = '00000000'
        bwbdt = '00000000'
        angdt = '00000000'
        bnddt = '00000000'
        gwldt = '00000000'
        ihran = '00000000'
        ktwrt = '0.00 '
        knumv = '1000008146'
        kalsm = 'A10001'
        stafo = 'SAP'
        lifre = '0010300006'
        upinc = '00001'
        lands = 'DE'
        stcegl = 'DE'
        stceg = 'DE123456789'
        absgr = '00'
        procstat = '02'
        rlwrt = '0.00 '
        retpc = '0.00 '
        dppct = '0.00 '
        dpamt = '0.00 '
        dpdat = '00000000'
        releasedate = '00000000'
*        inco2key = '00000000000000000000000000000000'
*        inco3key = '00000000000000000000000000000000'
*        inco4key = '00000000000000000000000000000000'
        grwcu = 'EUR'
        qtnerlstsubmsndate = '00000000'
        extrevtmstmp = '0.0000000 '
        forcecnt = '000000'
        fshitemgroup = '00000'
        fshvaslastitem = '00000'
        zapcgk = '0000'
        apcgkextend = '0000000000'
        zbasdate = '00000000'
        zstartdat = '00000000'
        zdev = '0.000 '
        zlimitdat = '00000000'
        hashcalbdat = '00000000'
        proce = '000000000'
        despdat = '00000000'
        paredat = '00000000'
        pfmcontract = '00000000'
        eqeindt = '00000000'
        keyid = '0000000000000000'
        otbvalue = '0.00 '
        otbresvalue = '0.00 '
        otbspecvalue = '0.00 '
      ) ).
    environment->insert_test_data( i_data = lt_/df5/i_ekko ).

    "Prepare test data for '/df5/i_poconf_items'
    lt_/df5/i_poconf_items = VALUE #(
      (
        purchaseorder = '4500000006'
        purchaseorderitem = '00010'
        supplierconfirmation = '0001'
        plant = '1010'
        material = 'TG13'
        materialclass = 'L001'
        requestedquantity = '20.000 '
        netprice = '13.00 '
        uom = 'ST'
        priceunit = '1 '
        orderpriceunit = 'ST'
        confirmationcontrolkey = '0001'
        confirmationcontrolcategory = 'AB'
        ekes_ebeln = '4500000006'
        ekes_ebelp = '00010'
        ekes_eindt = '20220302'
        ekes_menge = '15.000 '
        reference = 'CONFIRMATION1234'
        ekes_ebtyp = 'AB'
        reducedquantity = '0.000 '
        eket_eindt = '20220304'
        eket_menge = '20.000 '
      ) ).
    environment->insert_test_data( i_data = lt_/df5/i_poconf_items ).

    "Prepare test data for 'i_supplier'
    lt_i_supplier = VALUE #(
      (
        supplier = '0010300006'
        supplieraccountgroup = 'SUPL'
        suppliername = 'Inlandslieferant DE 6 (Retouren)'
        supplierfullname = 'Company Inlandslieferant DE 6 (Retouren)/22767 Hamburg'
        createdbyuser = 'DELAWARE'
        creationdate = '20211104'
        vatregistration = 'DE204894864'
        customer = '0010100006'
        internationallocationnumber1 = '0000000'
        internationallocationnumber2 = '00000'
        internationallocationnumber3 = '0'
        addressid = '0000023739'
        region = 'HH'
        organizationbpname1 = 'Inlandslieferant DE 6 (Retouren)'
        cityname = 'Hamburg'
        postalcode = '22767'
        streetname = 'HolstenstraÃƒÅ¸e 1142'
        country = 'DE'
        concatenatedinternationallocno = '0000000 &00000 &0'
        suplrqltyinprocmtcertfnvalidto = '00000000'
        supplierlanguage = 'D'
        phonenumber1 = '09990 25420-0'
        formofaddress = 'Company'
        birthdate = '00000000'
        sortfield = 'LIEFDE6'
*        brspcfctaxbasepercentagecode = '0'
      ) ).
    environment->insert_test_data( i_data = lt_i_supplier ).

  ENDMETHOD.

ENDCLASS.
