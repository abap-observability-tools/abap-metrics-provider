INTERFACE zif_amp_converter
PUBLIC .

  TYPES metric_store TYPE STANDARD TABLE OF zamp_store WITH KEY metric_scenario metric_group metric_key.

  METHODS convert
    IMPORTING
              metric_store             TYPE metric_store
    EXPORTING
              content_type             TYPE string
    RETURNING VALUE(converted_metrics) TYPE string.

ENDINTERFACE.
