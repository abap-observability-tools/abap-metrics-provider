CLASS zcl_amp_c_transport_states DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_transport_states IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    SELECT
    COUNT(*) AS count,
    command AS command,
    retcode AS retcode
    FROM tpstat
    INTO TABLE @DATA(states)
    WHERE moddate = @date_current_run
    GROUP BY command, retcode.


    LOOP AT states ASSIGNING FIELD-SYMBOL(<state>).

      DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = |{ <state>-command }_{ <state>-retcode }| metric_value = <state>-count ).
      COLLECT metric INTO metrics_current_run.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
