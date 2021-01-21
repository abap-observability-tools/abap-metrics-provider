CLASS zcl_amp_collector_utils DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS initialize_metrics
      IMPORTING metrics_last_run           TYPE zif_amp_collector=>metrics
      RETURNING VALUE(metrics_current_run) TYPE zif_amp_collector=>metrics.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_collector_utils IMPLEMENTATION.
  METHOD initialize_metrics.
    LOOP AT metrics_last_run ASSIGNING FIELD-SYMBOL(<previous_metric>).
      metrics_current_run = VALUE #( BASE metrics_current_run ( metric_key = <previous_metric>-metric_key metric_value = 0 ) ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
