CLASS zcl_amp_c_bal_logs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_bal_logs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    SELECT
    COUNT(*) AS count,
    object AS object,
    subobject AS subobject
    FROM balhdr
    INTO TABLE @DATA(bal_logs)
    WHERE aldate = @date_current_run
    GROUP BY object, subobject.


    LOOP AT bal_logs ASSIGNING FIELD-SYMBOL(<log>).

      DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = |{ <log>-object }_{ <log>-subobject }| metric_value = <log>-count ).
      COLLECT metric INTO metrics_current_run.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
