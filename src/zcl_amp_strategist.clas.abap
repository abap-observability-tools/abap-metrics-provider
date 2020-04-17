CLASS zcl_amp_strategist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! calls all classes for metrics collection  
    METHODS provide_metrics.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_strategist IMPLEMENTATION.
  METHOD provide_metrics.

    DATA metrics TYPE zif_amp_metrics_collector=>metrics.

    metrics = NEW zcl_amp_metrics_system( )->zif_amp_metrics_collector~get_metrics( ).

    metrics = NEW zcl_amp_metrics_performance( )->zif_amp_metrics_collector~get_metrics( ).

  ENDMETHOD.

ENDCLASS.