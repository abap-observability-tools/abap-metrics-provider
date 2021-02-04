CLASS zcl_amp_auth_checker DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized" lang="en">authority check scraping metrics</p>
    "! check if user is allowed to scrape metrics via SICF
    "! @parameter is_allowed | <p class="shorttext synchronized" lang="en">abap_true if authority check is successful
    "! </p>
    METHODS is_scraping_allowed
      RETURNING VALUE(is_allowed) TYPE flag.
    "! <p class="shorttext synchronized" lang="en">authority check providing metrics</p>
    "! check if user is allowed to provide metrics
    "! @parameter is_allowed | <p class="shorttext synchronized" lang="en">abap_true if authority check is successful
    "! </p>
    METHODS is_providing_allowed
      RETURNING VALUE(is_allowed) TYPE flag.
    "! <p class="shorttext synchronized" lang="en">authority check deleting metrics</p>
    "! check if user is allowed to delete metrics from the metrics store
    "! @parameter is_allowed | <p class="shorttext synchronized" lang="en">abap_true if authority check is successful
    "! </p>
    METHODS is_deleting_allowed
      RETURNING VALUE(is_allowed) TYPE flag.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_auth_checker IMPLEMENTATION.
  METHOD is_scraping_allowed.

    AUTHORITY-CHECK OBJECT 'ZAMP_AUTH'
      ID 'ZAMP_ACTIO' FIELD 'SCRAPER'.
    IF sy-subrc = 0.
      is_allowed = abap_true.
    ELSE.
      is_allowed = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD is_providing_allowed.

    AUTHORITY-CHECK OBJECT 'ZAMP_AUTH'
      ID 'ZAMP_ACTIO' FIELD 'PROVIDER'.
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
