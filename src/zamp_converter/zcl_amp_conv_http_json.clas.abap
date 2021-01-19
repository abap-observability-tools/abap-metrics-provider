CLASS zcl_amp_conv_http_json DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_converter.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_conv_http_json IMPLEMENTATION.

  METHOD zif_amp_converter~convert.

    DATA(metric_store_groups) = metric_store.

    SORT metric_store_groups BY metric_group.

    DELETE ADJACENT DUPLICATES FROM metric_store_groups COMPARING metric_group.



    converted_metrics = |\{|.

    LOOP AT metric_store_groups ASSIGNING FIELD-SYMBOL(<metric_store_group>).

      converted_metrics = converted_metrics &&
                          |"{ sy-sysid }_{ sy-mandt }_{ <metric_store_group>-metric_scenario }_{ <metric_store_group>-metric_group }" : \{|.

      LOOP AT metric_store ASSIGNING FIELD-SYMBOL(<metric>) WHERE metric_group = <metric_store_group>-metric_group.

        converted_metrics = converted_metrics && |"{ <metric>-metric_key }" : { <metric>-metric_value },|.

      ENDLOOP.

      converted_metrics = substring( val = converted_metrics off = 0 len = strlen( converted_metrics ) - 1 ).

      converted_metrics = converted_metrics && |\},|.

    ENDLOOP.

    converted_metrics = substring( val = converted_metrics off = 0 len = strlen( converted_metrics ) - 1 ).

    converted_metrics = converted_metrics && |\}|.


    content_type = 'application/json'.

  ENDMETHOD.
ENDCLASS.
