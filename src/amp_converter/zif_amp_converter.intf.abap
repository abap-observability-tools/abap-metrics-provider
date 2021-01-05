INTERFACE zif_amp_converter
PUBLIC .

  TYPES metric_store TYPE STANDARD TABLE OF zamp_store WITH KEY metric_scenario metric_collector metric_key.

  METHODS convert
    IMPORTING
              metric_store             TYPE metric_store
    RETURNING VALUE(converted_metrics) TYPE string.

ENDINTERFACE.
