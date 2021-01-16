CLASS zcl_amp_c_transactional_rfcs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_transactional_rfcs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA status TYPE string.

    SELECT
    COUNT(*) AS count,
    arfcstate AS status
    FROM arfcsstate
    INTO TABLE @DATA(rfcs)
    WHERE arfcdatum = @date_current_run
    GROUP BY arfcstate.

    LOOP AT rfcs ASSIGNING FIELD-SYMBOL(<rfc>).

      status = <rfc>-status.

      metrics_current_run = VALUE #( BASE metrics_current_run ( metric_key = status metric_value = <rfc>-count ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
