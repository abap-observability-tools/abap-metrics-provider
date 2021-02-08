CLASS zcl_amp_strategist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS provide_metrics
      IMPORTING scenario TYPE zamp_config_scen-metric_scenario.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES ty_stored_metrics TYPE STANDARD TABLE OF zamp_store WITH KEY metric_scenario metric_group metric_key.

    METHODS get_last_run
      IMPORTING
                scenario                TYPE zamp_store-metric_scenario
                metric_group            TYPE zamp_store-metric_group
      RETURNING VALUE(last_run_metrics) TYPE ty_stored_metrics.

    METHODS extract_date_time
      IMPORTING
        timestamp          TYPE zamp_store-metric_last_run
      EXPORTING
        date_last_run      TYPE d
        time_last_run      TYPE t
        date_current_run   TYPE d
        time_current_run   TYPE t
        current_time_stamp TYPE zamp_store-metric_last_run.

ENDCLASS.



CLASS zcl_amp_strategist IMPLEMENTATION.
  METHOD provide_metrics.

    DATA collector_metrics  TYPE zif_amp_collector=>metrics.
    DATA metrics            TYPE STANDARD TABLE OF zamp_store.
    DATA metrics_total      LIKE metrics.
    DATA metric_collector   TYPE REF TO zif_amp_collector.
    DATA timestamp_last_run TYPE zamp_metric_last_run.

    DATA(metric_collectors) = NEW zcl_amp_customizing_base( scenario )->get_metric_collectors( ).

    LOOP AT metric_collectors ASSIGNING FIELD-SYMBOL(<metric_collector>).

      CREATE OBJECT metric_collector TYPE (<metric_collector>-metric_class).

      DATA(metrics_last_run) = me->get_last_run( scenario = scenario
                                                 metric_group = <metric_collector>-metric_group ).

      TRY.
          timestamp_last_run = metrics_last_run[ 1 ]-metric_last_run.
        CATCH cx_sy_itab_line_not_found.
          CLEAR timestamp_last_run.
      ENDTRY.

      me->extract_date_time(
        EXPORTING
          timestamp = timestamp_last_run
        IMPORTING
          date_last_run      = DATA(date_last_run)
          time_last_run      = DATA(time_last_run)
          date_current_run   = DATA(date_current_run)
          time_current_run   = DATA(time_current_run)
          current_time_stamp = DATA(current_time_stamp) ).

      collector_metrics = CORRESPONDING #( metrics_last_run ).

      collector_metrics = metric_collector->get_metrics( last_run = timestamp_last_run
                                                         date_last_run = date_last_run
                                                         time_last_run = time_last_run
                                                         metrics_last_run = collector_metrics
                                                         date_current_run = date_current_run
                                                         time_current_run = time_current_run ).

      LOOP AT collector_metrics ASSIGNING FIELD-SYMBOL(<metric>).
        APPEND VALUE #( metric_scenario = scenario
                        metric_group = <metric_collector>-metric_group
                        metric_key = <metric>-metric_key
                        metric_value = <metric>-metric_value
                        metric_last_run = current_time_stamp ) TO metrics.
      ENDLOOP.

      APPEND LINES OF metrics TO metrics_total.
      CLEAR metrics.

    ENDLOOP.

    MODIFY zamp_store FROM TABLE @metrics_total.

  ENDMETHOD.

  METHOD get_last_run.

    SELECT *
      FROM zamp_store
      WHERE zamp_store~metric_scenario = @scenario
      AND zamp_store~metric_group = @metric_group
      INTO TABLE @last_run_metrics.

  ENDMETHOD.

  METHOD extract_date_time.

    DATA tz TYPE timezone.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone = tz.

    CONVERT TIME STAMP timestamp TIME ZONE tz
        INTO DATE date_last_run TIME time_last_run.

    GET TIME STAMP FIELD current_time_stamp.

    CONVERT TIME STAMP current_time_stamp TIME ZONE tz
        INTO DATE date_current_run TIME time_current_run.

  ENDMETHOD.

ENDCLASS.
