CLASS zcl_amp_strategist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS provide_metrics.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_strategist IMPLEMENTATION.
  METHOD provide_metrics.

    DATA metrics        TYPE zif_amp_metrics_collector=>metrics.
    DATA metrics_total  LIKE metrics.

    metrics = NEW zcl_amp_metrics_system( )->zif_amp_metrics_collector~get_metrics( ).
    APPEND LINES OF metrics TO metrics_total.

    metrics = NEW zcl_amp_metrics_performance( )->zif_amp_metrics_collector~get_metrics( ).
    APPEND LINES OF metrics TO metrics_total.

    MODIFY zamp_store FROM TABLE metrics_total.
  ENDMETHOD.

ENDCLASS.
