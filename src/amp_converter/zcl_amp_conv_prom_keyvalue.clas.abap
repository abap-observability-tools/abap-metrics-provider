CLASS zcl_amp_conv_prom_keyvalue DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_amp_converter.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amp_conv_prom_keyvalue IMPLEMENTATION.

  METHOD zif_amp_converter~convert.

    LOOP AT metric_store ASSIGNING FIELD-SYMBOL(<metric>).

      converted_metrics = converted_metrics &&
                          |{ sy-sysid }_{ sy-mandt }_{ <metric>-metric_scenario }_{ <metric>-metric_group }_{ <metric>-metric_key } { <metric>-metric_value }| &&
                          cl_abap_char_utilities=>newline.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
