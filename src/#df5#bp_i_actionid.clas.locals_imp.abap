CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.

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

ENDCLASS.

CLASS lhc_I_ACTIONID DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /df5/i_actionid.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /df5/i_actionid.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /df5/i_actionid.

    METHODS read FOR READ
      IMPORTING keys FOR READ /df5/i_actionid RESULT result.

    METHODS cba_ConfLines FOR MODIFY
      IMPORTING entities_cba FOR CREATE /df5/i_actionid\_ConfLines.

    METHODS rba_ConfLines FOR READ
      IMPORTING keys_rba FOR READ /df5/i_actionid\_ConfLines FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_I_ACTIONID IMPLEMENTATION.

  METHOD create.
    DATA lv_guid_22 TYPE sysuuid_22.

    CALL FUNCTION 'GUID_CREATE'
      IMPORTING
        ev_guid_22 = lv_guid_22.

    GET TIME STAMP FIELD DATA(lv_tsl2).
    lcl_buffer=>ms_buffer-mv_timestamp = lv_tsl2.
    lcl_buffer=>ms_buffer-mv_user = sy-uname.
    lcl_buffer=>ms_buffer-mv_guid = lv_guid_22.

    TRY.
        DATA(ls_action_header) = entities[ 1 ].

        lcl_buffer=>ms_buffer-ms_buffer_action = CORRESPONDING #( ls_action_header ).
        " In case of new contract header we will need to assign the generated number later on
        APPEND VALUE #( %cid     = ls_action_header-%cid
                        actionid = lv_guid_22 ) TO mapped-/df5/i_actionid.

      CATCH cx_sy_itab_line_not_found.
    ENDTRY.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD cba_ConfLines.
    TRY.
        DATA(lt_conf) = entities_cba[ 1 ].
        LOOP AT lt_conf-%target ASSIGNING FIELD-SYMBOL(<ls_conf>).
          APPEND CORRESPONDING #( <ls_conf> ) TO lcl_buffer=>ms_buffer-mt_buffer_conf_header.
        ENDLOOP.

      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD rba_ConfLines.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_I_POCONF_ID DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /df5/i_poconf_id.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /df5/i_poconf_id.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /df5/i_poconf_id.

    METHODS read FOR READ
      IMPORTING keys FOR READ /df5/i_poconf_id RESULT result.

    METHODS cba_Lines FOR MODIFY
      IMPORTING entities_cba FOR CREATE /df5/i_poconf_id\_Lines.

    METHODS rba_Lines FOR READ
      IMPORTING keys_rba FOR READ /df5/i_poconf_id\_Lines FULL result_requested RESULT result LINK association_links.

    METHODS cba_Log FOR MODIFY
      IMPORTING entities_cba FOR CREATE /df5/i_poconf_id\_Log.

    METHODS rba_Log FOR READ
      IMPORTING keys_rba FOR READ /df5/i_poconf_id\_Log FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_I_POCONF_ID IMPLEMENTATION.

  METHOD create.

*   READ TABLE entities INTO DATA(ls_confirmation_header) INDEX 1.
*    IF ls_confirmation_header IS NOT INITIAL.
*      MOVE-CORRESPONDING ls_confirmation_header TO lcl_buffer=>ms_buffer-ms_buffer_conf_header.
*    ENDIF.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD cba_Lines.
    TRY.
        DATA(lt_item) = entities_cba[ 1 ].
        LOOP AT lt_item-%target ASSIGNING FIELD-SYMBOL(<ls_item>).
          APPEND CORRESPONDING #( <ls_item> ) TO lcl_buffer=>ms_buffer-mt_buffer_line_item.
        ENDLOOP.

      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD rba_Lines.
  ENDMETHOD.

  METHOD cba_Log.
  ENDMETHOD.

  METHOD rba_Log.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_I_POCONF_LIST DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /df5/i_poconf_list.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /df5/i_poconf_list.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /df5/i_poconf_list.

    METHODS read FOR READ
      IMPORTING keys FOR READ /df5/i_poconf_list RESULT result.

ENDCLASS.

CLASS lhc_I_POCONF_LIST IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_I_POCONF_LOG DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /df5/i_poconf_log.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /df5/i_poconf_log.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /df5/i_poconf_log.

    METHODS read FOR READ
      IMPORTING keys FOR READ /df5/i_poconf_log RESULT result.

ENDCLASS.

CLASS lhc_I_POCONF_LOG IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_I_ACTIONID DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_I_ACTIONID IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
    DATA: lv_succes          TYPE boole_d,
          lv_contract_number TYPE ebeln,
          ls_ret_rollback    TYPE bapiret2,
          ls_ret_commit      TYPE bapiret2,
          lt_return          TYPE TABLE OF bapiret2.

    /df5/cl_poconfirmation=>create_confirmation(
      IMPORTING
        et_return = lt_return
        ev_succes = lv_succes
      CHANGING
        cs_buffer = lcl_buffer=>ms_buffer
    ).
  ENDMETHOD.

ENDCLASS.
