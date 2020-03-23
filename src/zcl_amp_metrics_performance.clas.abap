CLASS zcl_amp_metrics_performance DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_metrics_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_metrics_performance IMPLEMENTATION.
  METHOD zif_amp_metrics_collector~get_metrics.

    DATA(random_number_creator) = cl_abap_random_int=>create(
                                                     seed = cl_abap_random=>seed( )
                                                     min  = 1
                                                     max  = 10
                                                 ).

    metrics = VALUE #( BASE metrics ( metric_key = 'performance_dummy' metric_value = random_number_creator->get_next( ) ) ).

  ENDMETHOD.

ENDCLASS.
