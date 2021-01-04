CLASS zcl_amp_c_jobs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_jobs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA status TYPE string.

    SELECT
    COUNT(*) AS count,
    status AS status
    FROM v_op
    INTO TABLE @DATA(jobs)
    WHERE strtdate = @sy-datum
    GROUP BY status.

    LOOP AT jobs ASSIGNING FIELD-SYMBOL(<job>).

      "status from include LBTCHDEF
      status = SWITCH #( <job>-status
                          WHEN 'R' THEN 'running'
                          WHEN 'Y' THEN 'ready'
                          WHEN 'P' THEN 'scheduled'
                          WHEN 'P' THEN 'intercepted'
                          WHEN 'S' THEN 'released'
                          WHEN 'A' THEN 'aborted'
                          WHEN 'F' THEN 'finished'
                          WHEN 'Z' THEN 'put_active'
                          WHEN 'X' THEN 'unknown_state'
                          ELSE 'no status found' ).

      metrics = VALUE #( BASE metrics ( metric_key = |jobs_{ status }| metric_value = <job>-count ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
