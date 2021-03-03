CLASS zcl_amp_conv_http_json DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_converter .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS escape_json
      IMPORTING i_val        TYPE string
      RETURNING VALUE(r_val) TYPE string.
ENDCLASS.



CLASS zcl_amp_conv_http_json IMPLEMENTATION.

  METHOD zif_amp_converter~convert.

    DATA(metric_store_groups) = metric_store.
    SORT metric_store_groups BY metric_group.
    DELETE ADJACENT DUPLICATES FROM metric_store_groups COMPARING metric_group.

    converted_metrics = |\{|.

    LOOP AT metric_store_groups ASSIGNING FIELD-SYMBOL(<metric_store_group>).

      DATA(group_key) = |{ sy-sysid }_{ sy-mandt }_{ <metric_store_group>-metric_scenario }_{ <metric_store_group>-metric_group }|.

      converted_metrics = converted_metrics && |"{ escape_json( group_key ) }" : \{|.

      LOOP AT metric_store ASSIGNING FIELD-SYMBOL(<metric>) WHERE metric_group = <metric_store_group>-metric_group.
        converted_metrics = converted_metrics && |"{ escape_json( CONV #( <metric>-metric_key ) ) }" : { <metric>-metric_value },|.
      ENDLOOP.

      converted_metrics = substring( val = converted_metrics off = 0 len = strlen( converted_metrics ) - 1 ).
      converted_metrics = converted_metrics && |\},|.

    ENDLOOP.

    IF sy-subrc = 0.
      converted_metrics = substring( val = converted_metrics off = 0 len = strlen( converted_metrics ) - 1 ).
    ENDIF.

    converted_metrics = converted_metrics && |\}|.

    content_type = 'application/json'.

  ENDMETHOD.


  METHOD escape_json.
    r_val = escape( val = i_val format = cl_abap_format=>e_json_string ).
  ENDMETHOD.
ENDCLASS.
