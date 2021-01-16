INTERFACE zif_amp_collector
  PUBLIC .

  TYPES: BEGIN OF metric,
           metric_key   TYPE zamp_store-metric_key,
           metric_value TYPE zamp_store-metric_value,
         END OF metric.

  TYPES metrics TYPE STANDARD TABLE OF metric WITH KEY metric_key.

  METHODS get_metrics
    IMPORTING
              last_run                   TYPE zamp_store-metric_last_run
              date_last_run              TYPE d
              time_last_run              TYPE t
              metrics_last_run           TYPE metrics
              date_current_run           TYPE d
              time_current_run           TYPE t
    RETURNING VALUE(metrics_current_run) TYPE metrics.

ENDINTERFACE.
