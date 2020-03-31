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

    DATA cdata TYPE string.

    TRY.
        DATA(random_number_creator) = cl_abap_random_int=>create(
                                                         seed = cl_abap_random=>seed( )
                                                         min  = 1
                                                         max  = 10
                                                     ).

        DATA(url_path) = server->request->get_header_field( '~path' ).

        CASE url_path.

          WHEN '/amp/example/inputs/http'.

            cdata = |\{ "metric1" : { random_number_creator->get_next( ) },| &&
                    |   "metric2" : { random_number_creator->get_next( ) } \}|.

          WHEN '/amp/example/inputs/prometheus'.

            cdata = |metric1 { random_number_creator->get_next( ) }| && cl_abap_char_utilities=>newline &&
                    |metric2 { random_number_creator->get_next( ) }|  && cl_abap_char_utilities=>newline.

        ENDCASE.

      CATCH cx_abap_random.
        ASSERT 1 = 2.
    ENDTRY.

    server->response->set_cdata( cdata ).

  ENDMETHOD.
ENDCLASS.
