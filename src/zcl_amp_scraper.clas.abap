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
    DATA url_parameteres  TYPE tihttpnvp.

    SELECT *
    FROM zamp_store
    INTO TABLE @metric_store.

    "just to check the whole list of parameters in the debugger
    server->request->get_form_fields(
      CHANGING
        fields             =  url_parameteres
    ).

    DATA(scenario) = server->request->get_form_field(
        name               = 'scenario'
    ).

    DATA(cdata) = NEW zcl_amp_conv_http_json( )->zif_amp_converter~convert( metric_store ).

    server->response->set_cdata( cdata ).

  ENDMETHOD.

ENDCLASS.
