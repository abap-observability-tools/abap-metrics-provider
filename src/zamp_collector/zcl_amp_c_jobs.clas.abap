CLASS zcl_amp_c_jobs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS initialize_metrics
      IMPORTING metrics_last_run    TYPE zif_amp_collector=>metrics
      CHANGING  metrics_current_run TYPE zif_amp_collector=>metrics.

ENDCLASS.


CLASS zcl_amp_c_jobs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA status TYPE string.

    "init status
    me->initialize_metrics(
      EXPORTING
        metrics_last_run    = metrics_last_run
      CHANGING
        metrics_current_run = metrics_current_run
    ).

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

      metrics_current_run = VALUE #( BASE metrics_current_run ( metric_key = status metric_value = <job>-count ) ).

    ENDLOOP.

  ENDMETHOD.

  METHOD initialize_metrics.

    LOOP AT metrics_last_run ASSIGNING FIELD-SYMBOL(<previous_metric>).
      metrics_current_run = VALUE #( BASE metrics_current_run ( metric_key = <previous_metric>-metric_key metric_value = 0 ) ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
