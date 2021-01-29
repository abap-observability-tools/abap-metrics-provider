CLASS zcl_amp_c_transactional_rfcs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_transactional_rfcs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA status TYPE string.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    SELECT
    COUNT(*) AS count,
    arfcstate AS status
    FROM arfcsstate
    INTO TABLE @DATA(rfcs)
    WHERE arfcdatum = @date_current_run
    GROUP BY arfcstate.

    LOOP AT rfcs ASSIGNING FIELD-SYMBOL(<rfc>).

      status = <rfc>-status.

      DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = status metric_value = <rfc>-count ).
      COLLECT metric INTO metrics_current_run.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
