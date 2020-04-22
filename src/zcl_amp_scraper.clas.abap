CLASS zcl_amp_scraper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_extension.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_scraper IMPLEMENTATION.
  METHOD if_http_extension~handle_request.

    DATA metric_store  TYPE STANDARD TABLE OF zamp_store.

    SELECT *
    FROM zamp_store
    INTO TABLE @metric_store.

    DATA(cdata) = NEW zcl_amp_conv_http_json( )->zif_amp_converter~convert( metric_store ).

    server->response->set_cdata( cdata ).

  ENDMETHOD.

ENDCLASS.
