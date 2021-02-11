REPORT zamp_clear_zamp_store.

TABLES zamp_store.

SELECT-OPTIONS scenario FOR zamp_store-metric_scenario.
SELECT-OPTIONS group FOR zamp_store-metric_group.
SELECT-OPTIONS key FOR zamp_store-metric_key.

START-OF-SELECTION.

  IF NEW zcl_amp_auth_checker( )->is_deleting_allowed( ) = abap_true.
    DELETE FROM zamp_store
    WHERE metric_scenario IN @scenario
    AND metric_group IN @group
    AND metric_key IN @key.
    IF sy-subrc = 0.
      WRITE |{ sy-dbcnt } entries deleted|.
    ELSE.
      WRITE |no entries deleted|.
    ENDIF.
  ELSE.
    MESSAGE 'no authority' TYPE 'E'.
  ENDIF.
