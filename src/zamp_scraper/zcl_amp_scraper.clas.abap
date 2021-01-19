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

    DATA metric_store       TYPE STANDARD TABLE OF zamp_store.
    DATA url_parameteres    TYPE tihttpnvp.
    DATA content_type       TYPE string.

    "just to check the whole list of parameters in the debugger
    server->request->get_form_fields( CHANGING
                                        fields  =  url_parameteres ).

    DATA(scenario) = server->request->get_form_field( name = 'scenario' ).

    SELECT *
    FROM zamp_store
    INTO TABLE @metric_store
    WHERE metric_scenario = @scenario.

    DATA(converter) = NEW zcl_amp_customizing_base( scenario = CONV #( scenario ) )->get_metric_converter( ).


    DATA(cdata) = converter->convert( EXPORTING
                                        metric_store = metric_store
                                      IMPORTING
                                        content_type = content_type ).

    server->response->set_cdata( cdata ).
    server->response->set_content_type( content_type ).

  ENDMETHOD.

ENDCLASS.
