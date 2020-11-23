CLASS zcl_amp_customizing_base DEFINITION INHERITING FROM zcl_amp_customizing
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    METHODS get_metric_collectors REDEFINITION.
    METHODS get_metric_converter REDEFINITION.


  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_amp_customizing_base IMPLEMENTATION.

  METHOD get_metric_collectors.
    metric_collectors = me->metric_collectors.
  ENDMETHOD.

  METHOD get_metric_converter.
    DATA(metric_converter_class_name) = me->metric_converter_class_name.
    TRANSLATE metric_converter_class_name TO UPPER CASE.
    CREATE OBJECT converter_class TYPE (metric_converter_class_name).
  ENDMETHOD.

ENDCLASS.
