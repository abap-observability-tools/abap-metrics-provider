REPORT zamp_clear_zamp_store.

TABLES zamp_store.

SELECT-OPTIONS scenario FOR zamp_store-metric_scenario.
SELECT-OPTIONS group FOR zamp_store-metric_group.
SELECT-OPTIONS key FOR zamp_store-metric_key.
PARAMETERS date TYPE dats OBLIGATORY DEFAULT sy-datum.
PARAMETERS time TYPE tims OBLIGATORY DEFAULT sy-uzeit.

DATA metric_last_run TYPE zamp_store-metric_last_run.

START-OF-SELECTION.

  IF NEW zcl_amp_auth_checker( )->is_deleting_allowed( ) = abap_true.

    DATA tz TYPE timezone.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone = tz.

    CONVERT DATE date TIME time INTO TIME STAMP metric_last_run TIME ZONE tz.

    DELETE FROM zamp_store
    WHERE metric_scenario IN @scenario
    AND metric_group IN @group
    AND metric_key IN @key
    AND metric_last_run < @metric_last_run.
    IF sy-subrc = 0.
      WRITE |{ sy-dbcnt } entries deleted|.
    ELSE.
      WRITE |no entries deleted|.
    ENDIF.
  ELSE.
    MESSAGE 'no authority' TYPE 'E'.
  ENDIF.
