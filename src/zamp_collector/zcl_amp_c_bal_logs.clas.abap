CLASS zcl_amp_c_bal_logs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES: BEGIN OF bal_log,
             count     TYPE i,
             object    TYPE balobj_d,
             subobject TYPE balsubobj,
           END OF bal_log.

    TYPES bal_logs TYPE STANDARD TABLE OF bal_log WITH DEFAULT KEY.

    METHODS create_log_level_metrics
      IMPORTING bal_logs                TYPE bal_logs
                date_current_run        TYPE d
      RETURNING VALUE(metric_log_types) TYPE zif_amp_collector=>metrics.

    METHODS map_log_msgty
      IMPORTING msgty       TYPE msgty
      RETURNING VALUE(type) TYPE string.

ENDCLASS.



CLASS zcl_amp_c_bal_logs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.
    DATA bal_logs TYPE bal_logs.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    SELECT
      COUNT(*) AS count,
      object AS object,
      subobject AS subobject
      FROM balhdr
      INTO TABLE @bal_logs
      WHERE aldate = @date_current_run
      GROUP BY object, subobject.


    LOOP AT bal_logs ASSIGNING FIELD-SYMBOL(<log>).

      DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = |{ <log>-object }_{ <log>-subobject }| metric_value = <log>-count ).
      COLLECT metric INTO metrics_current_run.

    ENDLOOP.

    DATA(metric_log_types) = create_log_level_metrics( bal_logs = bal_logs date_current_run = date_current_run ).

    APPEND LINES OF metric_log_types TO metrics_current_run.


  ENDMETHOD.

  METHOD create_log_level_metrics.
    DATA messages TYPE STANDARD TABLE OF balm.

    LOOP AT bal_logs ASSIGNING FIELD-SYMBOL(<log>).
      CALL FUNCTION 'APPL_LOG_READ_DB'
        EXPORTING
          object    = <log>-object
          subobject = <log>-subobject
          date_from = date_current_run " Read-from date
          date_to   = date_current_run " Read-by date
        TABLES
          messages  = messages.

      LOOP AT messages ASSIGNING FIELD-SYMBOL(<message>).
        DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = |{ <log>-object }_{ <log>-subobject }_{ me->map_log_msgty( <message>-msgty ) }|
                                                        metric_value = 1 ).
        COLLECT metric INTO metric_log_types.
      ENDLOOP.

      CLEAR messages.

    ENDLOOP.
  ENDMETHOD.

  METHOD map_log_msgty.
    type = SWITCH #( msgty
                     WHEN 'I' THEN 'information'
                     WHEN 'W' THEN 'warning'
                     WHEN 'E' THEN 'error'
                     WHEN 'A' THEN 'abend'
                     WHEN 'X' THEN 'exit'
                     WHEN 'S' THEN 'success'
                     ELSE msgty ).
  ENDMETHOD.

ENDCLASS.