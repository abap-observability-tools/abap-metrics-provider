CLASS zcl_amp_metrics_system DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_metrics_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_metrics_system IMPLEMENTATION.
  METHOD zif_amp_metrics_collector~get_metrics.

    SELECT COUNT( * )
    INTO @DATA(number_of_shortdumps)
    FROM snap
    WHERE datum = @sy-datum
    AND   seqno = '000'.

    metrics = VALUE #( BASE metrics ( metric_key = 'shortdumps' metric_value = number_of_shortdumps ) ).

  ENDMETHOD.

ENDCLASS.
