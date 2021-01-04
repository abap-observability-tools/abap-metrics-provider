CLASS zcl_amp_strategist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS provide_metrics
      IMPORTING scenario TYPE zamp_config_scen-scenario.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_amp_strategist IMPLEMENTATION.
  METHOD provide_metrics.

    DATA metrics        TYPE zif_amp_collector=>metrics.
    DATA metrics_total  LIKE metrics.
    DATA metric_collector TYPE REF TO zif_amp_collector.

    DATA(metric_collectors) = NEW zcl_amp_customizing_base( scenario )->get_metric_collectors( ).

    LOOP AT metric_collectors ASSIGNING FIELD-SYMBOL(<metric_collector>).

      CREATE OBJECT metric_collector TYPE (<metric_collector>-metric_class).

      metrics = metric_collector->get_metrics( ).
      APPEND LINES OF metrics TO metrics_total.

    ENDLOOP.

    MODIFY zamp_store FROM TABLE metrics_total.
  ENDMETHOD.

ENDCLASS.
