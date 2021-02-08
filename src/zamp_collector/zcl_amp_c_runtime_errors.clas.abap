CLASS zcl_amp_c_runtime_errors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_runtime_errors IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    SELECT COUNT( * )
    INTO @DATA(number_of_runtime_errors)
    FROM snap
    WHERE datum = @date_current_run
    AND seqno = '000'.

    metrics_current_run = VALUE #( BASE metrics_current_run ( metric_key = 'number' metric_value = number_of_runtime_errors ) ).

  ENDMETHOD.

ENDCLASS.
