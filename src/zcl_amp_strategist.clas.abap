CLASS zcl_amp_strategist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS provide_metrics
      IMPORTING scenario TYPE zamp_config_scen-scenario.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_last_run
      IMPORTING
                scenario          TYPE zamp_scenario
                metric_group_name TYPE zamp_store-metric_group
      RETURNING VALUE(last_run)   TYPE zamp_store-metric_last_run.

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

    DATA collector_metrics TYPE zif_amp_collector=>metrics.
    DATA metrics           TYPE STANDARD TABLE OF zamp_store.
    DATA metrics_total     LIKE metrics.
    DATA metric_collector  TYPE REF TO zif_amp_collector.

    DATA(metric_collectors) = NEW zcl_amp_customizing_base( scenario )->get_metric_collectors( ).

    LOOP AT metric_collectors ASSIGNING FIELD-SYMBOL(<metric_collector>).

      CREATE OBJECT metric_collector TYPE (<metric_collector>-metric_class).

      DATA(last_run) = me->get_last_run( scenario = scenario
                                         metric_group_name = <metric_collector>-metric_group_name ).

      me->extract_date_time(
        EXPORTING
          timestamp = last_run
        IMPORTING
          date_last_run      = DATA(date_last_run)
          time_last_run      = DATA(time_last_run)
          date_current_run   = DATA(date_current_run)
          time_current_run   = DATA(time_current_run)
          current_time_stamp = DATA(current_time_stamp)
      ).

      collector_metrics = metric_collector->get_metrics( last_run = last_run
                                                         date_last_run = date_last_run
                                                         time_last_run = time_last_run
                                                         date_current_run = date_current_run
                                                         time_current_run = time_current_run ).

      LOOP AT collector_metrics ASSIGNING FIELD-SYMBOL(<metric>).
        APPEND VALUE #( metric_scenario = scenario
                        metric_group = <metric_collector>-metric_group_name
                        metric_key = <metric>-metric_key
                        metric_value = <metric>-metric_value
                        metric_last_run = current_time_stamp ) TO metrics.
      ENDLOOP.

      APPEND LINES OF metrics TO metrics_total.

    ENDLOOP.

    MODIFY zamp_store FROM TABLE metrics_total.

  ENDMETHOD.

  METHOD get_last_run.

    SELECT metric_last_run
          FROM zamp_store
          WHERE zamp_store~metric_scenario = @scenario
          AND zamp_store~metric_group = @metric_group_name
          INTO @last_run UP TO 1 ROWS.
    ENDSELECT.

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
