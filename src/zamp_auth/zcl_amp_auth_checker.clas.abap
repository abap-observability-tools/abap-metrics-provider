CLASS zcl_amp_auth_checker DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS is_scraping_allowed
      RETURNING VALUE(is_allowed) TYPE flag.
    METHODS is_providing_allowed
      RETURNING VALUE(is_allowed) TYPE flag.
    METHODS is_deleting_allowed
      RETURNING VALUE(is_allowed) TYPE flag.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_auth_checker IMPLEMENTATION.
  METHOD is_scraping_allowed.

    AUTHORITY-CHECK OBJECT 'ZAMP_AUTH'
     ID 'ZAMP_ACTIO' FIELD 'PROVIDER'.
    IF sy-subrc = 0.
      is_allowed = abap_true.
    ELSE.
      is_allowed = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD is_providing_allowed.

    AUTHORITY-CHECK OBJECT 'ZAMP_AUTH'
     ID 'ZAMP_ACTIO' FIELD 'SCRAPER'.
    IF sy-subrc = 0.
      is_allowed = abap_true.
    ELSE.
      is_allowed = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD is_deleting_allowed.
    AUTHORITY-CHECK OBJECT 'ZAMP_AUTH'
     ID 'ZAMP_ACTIO' FIELD 'DELETER'.
    IF sy-subrc = 0.
      is_allowed = abap_true.
    ELSE.
      is_allowed = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
