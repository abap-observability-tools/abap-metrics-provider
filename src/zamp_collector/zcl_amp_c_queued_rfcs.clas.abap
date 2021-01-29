CLASS zcl_amp_c_queued_rfcs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_queued_rfcs IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA name TYPE string.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    "transaction SMQ1
    SELECT
    COUNT(*) AS count,
    qname AS qname,
    dest AS dest,
    qstate AS status
    FROM trfcqout
    INTO TABLE @DATA(outbound_rfcs)
    WHERE qrfcdatum = @date_current_run
    GROUP BY qname, dest, qstate.

    LOOP AT outbound_rfcs ASSIGNING FIELD-SYMBOL(<outbound_rfc>).

      name = |outbound_{ <outbound_rfc>-qname }_{ <outbound_rfc>-dest }_{ <outbound_rfc>-status }|.

      DATA(outbound_metric) = VALUE zif_amp_collector=>metric( metric_key = name metric_value = <outbound_rfc>-count ).
      COLLECT outbound_metric INTO metrics_current_run.

    ENDLOOP.

    "transaction SMQ2
    SELECT
    COUNT(*) AS count,
    qname AS qname,
    dest AS dest,
    qstate AS status
    FROM trfcqin
    INTO TABLE @DATA(inbound_rfcs)
    WHERE qrfcdatum = @date_current_run
    GROUP BY qname, dest, qstate.

    LOOP AT inbound_rfcs ASSIGNING FIELD-SYMBOL(<inbound_rfc>).

      name = |inbound_{ <inbound_rfc>-qname }_{ <inbound_rfc>-dest }_{ <inbound_rfc>-status }|.

      DATA(inbound_metric) = VALUE zif_amp_collector=>metric( metric_key = name metric_value = <inbound_rfc>-count ).
      COLLECT inbound_metric INTO metrics_current_run.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
