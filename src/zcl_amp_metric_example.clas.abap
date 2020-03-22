CLASS zcl_amp_metric_example DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_extension.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AMP_METRIC_EXAMPLE IMPLEMENTATION.


  METHOD if_http_extension~handle_request.

    TRY.
        DATA(random_number_creator) = cl_abap_random_int=>create(
                                                         seed = cl_abap_random=>seed( )
                                                         min  = 1
                                                         max  = 10
                                                     ).

        DATA(json) = |\{ "metric1" : { random_number_creator->get_next( ) },| &&
                     |   "metric2" : { random_number_creator->get_next( ) } \}|.

      CATCH cx_abap_random.
        ASSERT 1 = 2.
    ENDTRY.

    server->response->set_cdata( json ).

  ENDMETHOD.
ENDCLASS.
