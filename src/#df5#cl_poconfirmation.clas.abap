CLASS /df5/cl_poconfirmation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: gty_t_conf_headers   TYPE STANDARD TABLE OF /df5/i_poconf_id WITH DEFAULT KEY,
           gty_t_contract_items TYPE STANDARD TABLE OF /df5/i_poconf_list WITH DEFAULT KEY,

           BEGIN OF gty_s_buffer,
             ms_buffer_action      TYPE /df5/i_actionid,
             ms_buffer_conf_header TYPE /df5/i_poconf_id,
             mt_buffer_conf_header TYPE gty_t_conf_headers,
             mt_buffer_line_item   TYPE gty_t_contract_items,
             mv_guid               TYPE sysuuid_22,
             mv_user               TYPE uname,
             mv_timestamp          TYPE timestampl,
           END OF gty_s_buffer.

    CLASS-DATA: ms_buffer TYPE gty_s_buffer.

    CLASS-METHODS:
      create_confirmation
        EXPORTING
          et_return TYPE bapiret2_t
          ev_succes TYPE boole_d
        CHANGING
          cs_buffer TYPE gty_s_buffer,
      get_eket_info FOR TABLE FUNCTION /df5/p_eket_tf.

  PROTECTED SECTION.
    CLASS-METHODS
      me_po_confirm
        IMPORTING
          it_items          TYPE bapimeconf_t_item
          it_confirmations  TYPE bapimeconf_t_detail
          it_confirmationsx TYPE bapimeconf_t_detailx
          it_poupdates      TYPE gty_t_contract_items
          iv_ebeln          TYPE ebeln
          iv_updatepo       TYPE abap_bool
        EXPORTING
          et_return         TYPE bapiret2_t
          ev_errors         TYPE abap_bool.

  PRIVATE SECTION.
ENDCLASS.



CLASS /DF5/CL_POCONFIRMATION IMPLEMENTATION.


  METHOD create_confirmation.
    DATA: ls_polist            TYPE /df5/i_poconf_list,
          lt_temppolist        TYPE TABLE OF /df5/i_poconf_list,
          lv_errors            TYPE abap_bool,
          lv_purchaseorder     TYPE bapimepoheader-po_number,
          ls_poheader          TYPE bapimepoheader,
          lv_ebelp             TYPE ebelp,
          lv_changePO          TYPE abap_bool,
          ls_poheaderx         TYPE bapimepoheaderx,
          ls_bapimeconfitem    TYPE bapimeconfitem,
          ls_bapimeconfitemx   TYPE bapimeconfitemx,
          lt_bapimeconfitemx   TYPE TABLE OF bapimeconfitemx,
          lt_bapimeconfitem    TYPE TABLE OF bapimeconfitem,
          ls_bapimeconfdetail  TYPE bapimeconfdetail,
          lt_bapimeconfdetail  TYPE TABLE OF bapimeconfdetail,
          lt_bapimeconfdetailx TYPE TABLE OF bapimeconfdetailx,
          ls_bapimeconfdetailx TYPE bapimeconfdetailx,
          lt_return            TYPE TABLE OF bapiret2,
          ls_return            TYPE bapiret2,
          lv_bapi_error        TYPE abap_bool,
          ls_confirmation      TYPE /df5/db_pcid,
          lt_log               TYPE TABLE OF /df5/db_poco,
          ls_action            TYPE /df5/db_acid.

*    lv_errors = abap_false. "Default is abap_false
    LOOP AT cs_buffer-mt_buffer_line_item INTO ls_polist GROUP BY ls_polist-PurchaseOrder.
      LOOP AT GROUP ls_polist INTO DATA(ls_line).
        IF lv_ebelp <> ls_line-PurchaseOrderLine.
          ls_bapimeconfitem-item_no = ls_line-PurchaseOrderLine.
          lv_ebelp = ls_line-PurchaseOrderLine.
          APPEND ls_bapimeconfitem TO lt_bapimeconfitem.
        ENDIF.

        ls_bapimeconfdetail-item_no         = ls_line-PurchaseOrderLine.
        ls_bapimeconfdetail-conf_ser        = ls_line-SupplierConfirmation.
        ls_bapimeconfdetail-conf_category   = 'AB'.
        ls_bapimeconfdetail-deliv_date_typ  = '1'.
        ls_bapimeconfdetail-deliv_date      = ls_line-ConfirmedDelDate.
        ls_bapimeconfdetail-quantity        = ls_line-Quantity.
        ls_bapimeconfdetail-reference       = ls_line-Reference.
        ls_bapimeconfdetail-creat_date      = sy-datlo.
        ls_bapimeconfdetail-creat_time      = sy-timlo.
        ls_bapimeconfdetail-mpn             = ls_line-Material.
        ls_bapimeconfdetailx-item_no        = ls_line-PurchaseOrderLine.
        ls_bapimeconfdetailx-conf_ser       = ls_line-SupplierConfirmation.
        ls_bapimeconfdetailx-item_nox       = 'X'.
        ls_bapimeconfdetailx-conf_serx      = 'X'.
        ls_bapimeconfdetailx-conf_category  = 'X'.
        ls_bapimeconfdetailx-deliv_date_typ = 'X'.
        ls_bapimeconfdetailx-deliv_date     = 'X'.
        ls_bapimeconfdetailx-quantity       = 'X'.
        ls_bapimeconfdetailx-mpn            = 'X'.
        ls_bapimeconfdetailx-creat_date     = 'X'.
        ls_bapimeconfdetailx-creat_time     = 'X'.
        ls_bapimeconfdetailx-reference      = 'X'.

        IF ls_line-Changed = 'X'.
          lv_changepo = abap_true.
          APPEND CORRESPONDING #( ls_line ) TO lt_temppolist.
        ENDIF.

        APPEND ls_bapimeconfdetail TO lt_bapimeconfdetail.
        APPEND ls_bapimeconfdetailx TO lt_bapimeconfdetailx.
      ENDLOOP.

      lv_purchaseorder = ls_polist-PurchaseOrder.
      me_po_confirm(
        EXPORTING
          it_items          = lt_bapimeconfitem
          it_confirmations  = lt_bapimeconfdetail
          it_confirmationsx = lt_bapimeconfdetailx
          it_poupdates      = lt_temppolist
          iv_ebeln          = lv_purchaseorder
          iv_updatepo       = lv_changePO
        IMPORTING
          et_return         = lt_return
          ev_errors         = lv_bapi_error ##COMPATIBLE
      ).

      IF lv_bapi_error = abap_true.
        lv_errors = lv_bapi_error.
      ENDIF.

      CLEAR:
        lt_bapimeconfitem,
        lt_bapimeconfdetail,
        lt_bapimeconfdetailx,
        lt_temppolist,
        lv_ebelp,
        lv_bapi_error,
        ls_confirmation,
        lt_log.

      ls_confirmation-actionid = cs_buffer-mv_guid.
      ls_confirmation-purchaseorder = lv_purchaseorder.
      ls_confirmation-created_on = cs_buffer-mv_timestamp.
      ls_confirmation-created_by = sy-uname.
      INSERT /df5/db_pcid FROM ls_confirmation.     "#EC CI_IMUD_NESTED

      FREE lt_log.

      DELETE ADJACENT DUPLICATES FROM lt_return.
      LOOP AT lt_return ASSIGNING FIELD-SYMBOL(<ls_return>).
        APPEND INITIAL LINE TO lt_log ASSIGNING FIELD-SYMBOL(<ls_log>).
        <ls_log>-zactionid = cs_buffer-mv_guid.
        <ls_log>-purchaseorder = lv_purchaseorder.
        <ls_log>-zfield = <ls_return>-field.
        <ls_log>-zlogid = <ls_return>-id.
        <ls_log>-zlog_msg_no = sy-tabix."<ls_return>-log_msg_no.
        <ls_log>-zlog_no = <ls_return>-log_no.
        <ls_log>-zmessage = <ls_return>-message.
        <ls_log>-zmessage_v1 = <ls_return>-message_v1.
        <ls_log>-zmessage_v2 = <ls_return>-message_v2.
        <ls_log>-zmessage_v2 = <ls_return>-message_v2.
        <ls_log>-zmessage_v3 = <ls_return>-message_v3.
        <ls_log>-zmessage_v4 = <ls_return>-message_v4.
        <ls_log>-znumber = <ls_return>-number.
        <ls_log>-zparameter = <ls_return>-parameter.
        <ls_log>-zrow = <ls_return>-row.
        <ls_log>-zsystem = <ls_return>-system.
        <ls_log>-ztype = <ls_return>-type.
      ENDLOOP.

      INSERT /df5/db_poco FROM TABLE lt_log.        "#EC CI_IMUD_NESTED
    ENDLOOP.

    IF lv_errors EQ abap_false.
      " if no error fill the return
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' DESTINATION 'NONE'.
    ELSE.
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK' DESTINATION 'NONE'.
    ENDIF.

    GET TIME STAMP FIELD DATA(lv_tsl2).
    ls_action-actionid   = cs_buffer-mv_guid.
    ls_action-created_on = lv_tsl2.
    ls_action-created_by = sy-uname.

    INSERT /df5/db_acid FROM ls_action.             "#EC CI_IMUD_NESTED
  ENDMETHOD.


  METHOD get_eket_info BY DATABASE FUNCTION
          FOR HDB
          LANGUAGE SQLSCRIPT
          OPTIONS READ-ONLY
          USING eket.


    RETURN
      SELECT mandt, ebeln AS purchaseOrder, ebelp AS purchaseOrderLine, MIN(eindt) AS date
        FROM eket
        WHERE eindt >= to_dats(current_date)
        GROUP BY mandt, ebeln, ebelp
      UNION
      SELECT mandt, ebeln AS purchaseOrder, ebelp AS purchaseOrderLine, MAX(eindt) AS date
        FROM (
          select mandt, ebeln, ebelp, eindt, menge
            FROM eket AS eket1
            WHERE eindt < to_dats(current_date)
        ) AS ekettemp
        WHERE NOT EXISTS (
          SELECT mandt, ebeln AS purchaseOrder, ebelp AS purchaseOrderLine, MIN(eindt) AS date
            FROM eket
            WHERE eindt >= to_dats(current_date)
              AND ekettemp.ebeln = eket.ebeln
              and ekettemp.ebelp = eket.ebelp
            group by mandt, ebeln, ebelp
        )
        GROUP BY mandt, ebeln, ebelp;

  ENDMETHOD.


  METHOD me_po_confirm.
    DATA: lv_errors        TYPE abap_bool,
          lv_purchaseorder TYPE bapimepoheader-po_number,
          ls_poheader      TYPE bapimepoheader,
          ls_poheaderx     TYPE bapimepoheaderx,
          lt_return_change TYPE STANDARD TABLE OF bapiret2,
          ls_poitem        TYPE bapimepoitem,
          lt_poitem        TYPE STANDARD TABLE OF bapimepoitem,
          ls_poitemx       TYPE bapimepoitemx,
          lt_poitemx       TYPE STANDARD TABLE OF bapimepoitemx,
          ls_poschedule    TYPE bapimeposchedule,
          lt_poschedule    TYPE STANDARD TABLE OF bapimeposchedule,
          ls_poschedulex   TYPE bapimeposchedulx,
          lt_poschedulex   TYPE STANDARD TABLE OF bapimeposchedulx.

*    lv_errors = abap_false. "Default is abap_false

    CALL FUNCTION 'ME_PO_CONFIRM' DESTINATION 'NONE'
      EXPORTING
        document_no   = iv_ebeln
        item          = it_items
        confirmation  = it_confirmations
        confirmationx = it_confirmationsx
      IMPORTING
        return        = et_return.

    IF sy-subrc = 0.
      LOOP AT et_return ASSIGNING FIELD-SYMBOL(<lfs_return>).
        IF <lfs_return>-type = 'E' OR <lfs_return>-type = 'A'.
          lv_errors = abap_true.
          "CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
          "EXIT.
        ENDIF.
      ENDLOOP.
    ELSE.
      lv_errors = abap_true.
    ENDIF.

    IF iv_updatepo EQ abap_true.
      LOOP AT it_poupdates INTO DATA(ls_lines).
        ls_poitem-po_item  = ls_lines-purchaseorderline.
        ls_poitem-stge_loc = ls_lines-storagelocation.
        ls_poitem-net_price = ls_lines-netprice.
        lt_poitem = VALUE #( BASE lt_poitem ( ls_poitem ) ).

        ls_poitemx-po_item  = ls_lines-purchaseorderline.
        ls_poitemx-stge_loc = 'X'.
        ls_poitemx-net_price = 'X'.
        lt_poitemx = VALUE #( BASE lt_poitemx ( ls_poitemx ) ).
      ENDLOOP.

      CALL FUNCTION 'BAPI_PO_CHANGE' DESTINATION 'NONE'
        EXPORTING
          purchaseorder = iv_ebeln
          poheader      = ls_poheader
          poheaderx     = ls_poheaderx
        TABLES
          return        = lt_return_change
          poitem        = lt_poitem
          poitemx       = lt_poitemx.

      IF sy-subrc = 0.
        LOOP AT lt_return_change ASSIGNING FIELD-SYMBOL(<lfs_return2>).
          APPEND <lfs_return2> TO et_return.
          IF <lfs_return2>-type = 'E' OR <lfs_return2>-type = 'A'.
            lv_errors = abap_true.
          ENDIF.
        ENDLOOP.

      ELSE.
        lv_errors = abap_true.
      ENDIF.

    ENDIF.

    ev_errors = lv_errors.
  ENDMETHOD.
ENDCLASS.
