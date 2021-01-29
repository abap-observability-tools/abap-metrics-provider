CLASS zcl_amp_c_batch_input DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF batch_input,
             count   TYPE i,
             groupid TYPE apq_grpn,
             progid  TYPE apq_prog,
             state   TYPE apq_stat,
           END OF batch_input.

    TYPES batch_inputs TYPE SORTED TABLE OF batch_input WITH UNIQUE KEY groupid progid state.

    METHODS map_batch_state
      IMPORTING state       TYPE apq_stat
      RETURNING VALUE(type) TYPE string.

ENDCLASS.



CLASS zcl_amp_c_batch_input IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA batch_inputs TYPE batch_inputs.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    SELECT
    COUNT(*) AS count,
    groupid AS groupid,
    progid AS progid,
    qstate AS state
    FROM apqi
    WHERE ( datatyp = 'BDC' OR datatyp = 'BDCE' OR datatyp = 'RODC' )
    GROUP BY groupid, progid, qstate
    INTO TABLE @batch_inputs.

    LOOP AT batch_inputs ASSIGNING FIELD-SYMBOL(<batch>).

      DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = |{ <batch>-groupid }_{ <batch>-progid }_{ me->map_batch_state( state = <batch>-state ) }|
                                                      metric_value = <batch>-count ).
      COLLECT metric INTO metrics_current_run.

    ENDLOOP.

  ENDMETHOD.

  METHOD map_batch_state.
    type = SWITCH #( state
                     WHEN 'R' THEN 'running'
                     WHEN 'C' THEN 'creating'
                     WHEN 'E' THEN 'error'
                     WHEN 'F' THEN 'finished'
                     WHEN '' THEN 'unprocessed'
                     ELSE state ).
  ENDMETHOD.

ENDCLASS.
