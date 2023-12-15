INTERFACE /df5/if_mm_po_conf
  PUBLIC.

  INTERFACES if_badi_interface.

  TYPES lty_t_polist TYPE STANDARD TABLE OF /df5/i_poconf_list.

  METHODS after_lines_confirmed
    IMPORTING it_unmodified_polist TYPE lty_t_polist
              it_modified_polist   TYPE lty_t_polist.

ENDINTERFACE.
