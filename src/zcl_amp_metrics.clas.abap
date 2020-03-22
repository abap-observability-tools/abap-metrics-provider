CLASS zcl_amp_metrics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_extension.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_metrics IMPLEMENTATION.
  METHOD if_http_extension~handle_request.

    SELECT COUNT( * )
    INTO @DATA(number_of_shortdumps)
    FROM snap
    WHERE datum = @sy-datum
    and   seqno = '000'.

    DATA(json) = |\{ "shortdumps": \{ "number_of_shortdumps" : { number_of_shortdumps }\} \}|.


    server->response->set_cdata( json ).

  ENDMETHOD.

ENDCLASS.
