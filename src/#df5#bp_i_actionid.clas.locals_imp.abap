CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.

    TYPES:
      lty_t_conf_headers   TYPE STANDARD TABLE OF /df5/i_poconf_id WITH EMPTY KEY,
      lty_t_contract_items TYPE STANDARD TABLE OF /df5/i_poconf_list WITH EMPTY KEY,

      BEGIN OF lty_s_buffer,
        ms_buffer_action      TYPE /df5/i_actionid,
        ms_buffer_conf_header TYPE /df5/i_poconf_id,
        mt_buffer_conf_header TYPE lty_t_conf_headers,
        mt_buffer_line_item   TYPE lty_t_contract_items,
        mv_guid               TYPE sysuuid_22,
        mv_user               TYPE uname,
        mv_timestamp          TYPE timestampl,
      END OF lty_s_buffer.

    CLASS-METHODS:
      get_buffer
        RETURNING VALUE(rs_result) TYPE lty_s_buffer,
      set_buffer
        IMPORTING
          is_buffer TYPE lty_s_buffer.

  PRIVATE SECTION.
    CLASS-DATA gs_buffer TYPE lty_s_buffer.

ENDCLASS.

CLASS lcl_buffer IMPLEMENTATION.

  METHOD get_buffer.
    rs_result = gs_buffer.
  ENDMETHOD.

  METHOD set_buffer.
    gs_buffer = is_buffer.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_i_actionid DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /df5/i_actionid.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /df5/i_actionid.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /df5/i_actionid.

    METHODS read FOR READ
      IMPORTING keys FOR READ /df5/i_actionid RESULT result.

    METHODS cba_conflines FOR MODIFY
      IMPORTING entities_cba FOR CREATE /df5/i_actionid\_conflines.

    METHODS rba_conflines FOR READ
      IMPORTING keys_rba FOR READ /df5/i_actionid\_conflines FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_i_actionid IMPLEMENTATION.

  METHOD create.
    TRY.
        DATA(lv_guid_22) = cl_system_uuid=>create_uuid_c22_static( ).
        DATA(ls_buffer) = lcl_buffer=>get_buffer( ).

        GET TIME STAMP FIELD DATA(lv_tsl2).
        ls_buffer-mv_timestamp = lv_tsl2.
        ls_buffer-mv_user = sy-uname.
        ls_buffer-mv_guid = lv_guid_22.

        TRY.
            DATA(ls_action_header) = entities[ 1 ].

            ls_buffer-ms_buffer_action = CORRESPONDING #( ls_action_header ).
            " In case of new contract header we will need to assign the generated number later on
            APPEND VALUE #( %cid     = ls_action_header-%cid
                            actionid = lv_guid_22 ) TO mapped-/df5/i_actionid.
            lcl_buffer=>set_buffer( is_buffer = ls_buffer ).

          CATCH cx_sy_itab_line_not_found.              "#EC NO_HANDLER
        ENDTRY.

      CATCH cx_uuid_error.                              "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD cba_conflines.
    DATA(ls_buffer) = lcl_buffer=>get_buffer( ).

    TRY.
        DATA(lt_conf) = entities_cba[ 1 ].

        LOOP AT lt_conf-%target ASSIGNING FIELD-SYMBOL(<ls_conf>).
          APPEND CORRESPONDING #( <ls_conf> ) TO ls_buffer-mt_buffer_conf_header.
        ENDLOOP.

        lcl_buffer=>set_buffer( is_buffer = ls_buffer ).

      CATCH cx_sy_itab_line_not_found.                  "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.

  METHOD rba_conflines.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_i_poconf_id DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE /df5/i_poconf_id.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE /df5/i_poconf_id.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE /df5/i_poconf_id.

    METHODS read FOR READ
      IMPORTING keys FOR READ /df5/i_poconf_id RESULT result.

    METHODS cba_lines FOR MODIFY
      IMPORTING entities_cba FOR CREATE /df5/i_poconf_id\_lines.

    METHODS rba_lines FOR READ
      IMPORTING keys_rba FOR READ /df5/i_poconf_id\_lines FULL result_requested RESULT result LINK association_links.

    METHODS cba_log FOR MODIFY
      IMPORTING entities_cba FOR CREATE /df5/i_poconf_id\_log.

    METHODS rba_log FOR READ
      IMPORTING keys_rba FOR READ /df5/i_poconf_id\_log FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_i_poconf_id IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD cba_lines.
    DATA(ls_buffer) = lcl_buffer=>get_buffer( ).

    TRY.
        DATA(lt_item) = entities_cba[ 1 ].

        LOOP AT lt_item-%target ASSIGNING FIELD-SYMBOL(<ls_item>).
          APPEND CORRESPONDING #( <ls_item> ) TO ls_buffer-mt_buffer_line_item.
        ENDLOOP.

        lcl_buffer=>set_buffer( is_buffer = ls_buffer ).

      CATCH cx_sy_itab_line_not_found.                  "#EC NO_HANDLER
    ENDTRY.
  ENDMETHOD.

  METHOD rba_lines.
  ENDMETHOD.

  METHOD cba_log.
  ENDMETHOD.

  METHOD rba_log.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_i_poconf_list DEFINITION INHERITING FROM cl_abap_behavior_handler.
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

CLASS lhc_i_poconf_list IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_i_poconf_log DEFINITION INHERITING FROM cl_abap_behavior_handler.
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

CLASS lhc_i_poconf_log IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_i_actionid DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_i_actionid IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
    DATA(ls_buffer) = lcl_buffer=>get_buffer( ).

    /df5/cl_poconfirmation=>create_confirmation(
      CHANGING
        cs_buffer = ls_buffer
    ).
  ENDMETHOD.

ENDCLASS.
