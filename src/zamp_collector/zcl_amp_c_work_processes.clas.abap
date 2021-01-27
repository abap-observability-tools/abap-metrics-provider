CLASS zcl_amp_c_work_processes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS map_worker_type
      IMPORTING
        wp_type            TYPE ssi_worker_info-wp_type
      RETURNING
        VALUE(worker_type) TYPE string.
    METHODS map_worker_state
      IMPORTING
        state               TYPE ssi_worker_info-state
      RETURNING
        VALUE(worker_state) TYPE string.
ENDCLASS.


CLASS zcl_amp_c_work_processes IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA servers TYPE STANDARD TABLE OF msxxlist.

    metrics_current_run = zcl_amp_collector_utils=>initialize_metrics( metrics_last_run = metrics_last_run ).

    CALL FUNCTION 'TH_SERVER_LIST'
      TABLES
        list           = servers
      EXCEPTIONS
        no_server_list = 1
        OTHERS         = 2.
    IF sy-subrc <> 0.
      ASSERT 1 = 2.
    ENDIF.

    LOOP AT servers ASSIGNING FIELD-SYMBOL(<server>).

      TRY.
          DATA(workers) = NEW cl_server_info( CONV #( <server>-name ) )->get_worker_list( ).
        CATCH cx_ssi_no_auth.
          ASSERT 1 = 2.
      ENDTRY.

      LOOP AT workers ASSIGNING FIELD-SYMBOL(<worker>).

        DATA(worker_type) = map_worker_type( <worker>-wp_type ).

        DATA(worker_state) = map_worker_state( <worker>-state ).

        DATA(name) = |{ <server>-name }_{ worker_type }_{ worker_state }|.

        DATA(metric) = VALUE zif_amp_collector=>metric( metric_key = name metric_value  = 1 ).
        COLLECT metric INTO metrics_current_run.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.


  METHOD map_worker_type.

    worker_type  = SWITCH string( wp_type
                                   WHEN 0 THEN 'NO_WP'
                                   WHEN 1 THEN 'Dialog'
                                   WHEN 2 THEN 'Update'
                                   WHEN 3 THEN 'Enqueue'
                                   WHEN 4 THEN 'Batch'
                                   WHEN 5 THEN 'Spool'
                                   WHEN 6 THEN 'Update2' ).

  ENDMETHOD.


  METHOD map_worker_state.

    "from Include DP_TH_DEFS
    worker_state  = SWITCH string( state
                                   WHEN 0 THEN 'no_change'
                                   WHEN 1 THEN 'wp_slot_free'
                                   WHEN 2 THEN 'wp_wait'
                                   WHEN 4 THEN 'wp_run'
                                   WHEN 8 THEN 'wp_hold'
                                   WHEN 16 THEN 'wp_killed '
                                   WHEN 32 THEN 'wp_shutdown'
                                   WHEN 64 THEN 'wp_standby'
                                   WHEN 64 THEN 'wp_restricted'
                                   WHEN 128 THEN 'wp_new' ).

  ENDMETHOD.

ENDCLASS.
