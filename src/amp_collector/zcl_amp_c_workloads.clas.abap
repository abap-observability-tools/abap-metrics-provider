CLASS zcl_amp_c_workloads DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_workloads IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA no_of_records       TYPE sapwlsrirn.
    DATA normal_records      TYPE sapwlnormrecs.

    DATA response_time       TYPE p.
    DATA cpu_time            TYPE p.

    DATA tz TYPE timezone.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone = tz.

    GET TIME STAMP FIELD DATA(timestamp_current).

    CONVERT TIME STAMP timestamp_current TIME ZONE tz
        INTO DATE DATA(date_current) TIME DATA(time_current).

    CALL FUNCTION 'SAPWL_STATREC_DIRECT_READ'
      EXPORTING
        read_start_date             = date_last_run
        read_start_time             = time_last_run
        read_end_date               = date_current
        read_end_time               = time_current
      IMPORTING
        records_read                = no_of_records
        normal_records              = normal_records
      EXCEPTIONS
        wrong_parameter_combination = 1
        file_problems               = 2
        convert_overflow            = 3
        OTHERS                      = 4.
    IF sy-subrc = 0.

      LOOP AT normal_records ASSIGNING FIELD-SYMBOL(<normal_record>).

        response_time  = response_time + <normal_record>-respti.
        cpu_time       = cpu_time + <normal_record>-cputi.

      ENDLOOP.

      metrics = VALUE #( BASE metrics
                          ( metric_key = 'workload_no_of_records' metric_value = no_of_records )
                          ( metric_key = 'workload_response_time' metric_value = response_time )
                          ( metric_key = 'workload_cpu_time' metric_value = cpu_time ) ).


    ELSE.
      ASSERT 1 = 2.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
