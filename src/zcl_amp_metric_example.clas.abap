CLASS zcl_amp_metric_example DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_extension.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_metric_example IMPLEMENTATION.


  METHOD if_http_extension~handle_request.

    DATA json TYPE string.

    json = |\{ "metric1" : 2,| &&
           |   "metric2" : 1 \}|.

    server->response->set_cdata( json ).

  ENDMETHOD.
ENDCLASS.
