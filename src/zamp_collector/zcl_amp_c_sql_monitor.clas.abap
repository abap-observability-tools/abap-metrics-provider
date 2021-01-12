CLASS zcl_amp_c_sql_monitor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_collector.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_c_sql_monitor IMPLEMENTATION.
  METHOD zif_amp_collector~get_metrics.

    DATA(last_measurement_interval) = cl_sqlm_measurement_interval=>create_instance( )->get_last_measurement_interval( ).

    " display data of last hour
    DATA(from) = last_measurement_interval-unixtimeto - 3600.
    DATA(to) = last_measurement_interval-unixtimeto.

    DATA(sqlm) = cl_sqlm_data_timeprofile=>get_instance( timeslice = VALUE #( timefrom = from  timeto = to ) ).
    DATA(records) = sqlm->get_records( upto = 5 ).
    DATA(totaldbtime) = REDUCE i( INIT sum = 0 FOR record IN records NEXT sum = sum + record-rtsum ).

    metrics = VALUE #( BASE metrics ( metric_key = 'totaldbtime' metric_value = totaldbtime ) ).

  ENDMETHOD.

ENDCLASS.
