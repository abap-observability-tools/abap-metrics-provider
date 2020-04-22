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

    converted_metrics = |\{|.
    LOOP AT metric_store ASSIGNING FIELD-SYMBOL(<metric>).
      converted_metrics = converted_metrics && |"{ <metric>-metric_key }": \{ "{ <metric>-metric_key }" : { <metric>-metric_value }\},|.
    ENDLOOP.
    converted_metrics = substring( val = converted_metrics off = 0 len = strlen( converted_metrics ) - 1 ).
    converted_metrics = converted_metrics && |\}|.

  ENDMETHOD.

ENDCLASS.
