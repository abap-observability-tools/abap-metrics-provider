INTERFACE zif_amp_metrics_collector
  PUBLIC .

  TYPES: BEGIN OF metric,
           metric_key   TYPE string,
           metric_value TYPE string,
         END OF metric.

  TYPES metrics TYPE STANDARD TABLE OF metric WITH KEY metric_key.

  "!call all classes that are collecting metrics
  METHODS get_metrics RETURNING VALUE(metrics) TYPE metrics.

ENDINTERFACE.