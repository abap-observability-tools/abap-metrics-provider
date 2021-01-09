CLASS zcl_amp_customizing DEFINITION PUBLIC ABSTRACT.
  PUBLIC SECTION.

    TYPES ty_metric_collectors TYPE STANDARD TABLE OF zamp_config_prov WITH KEY metric_group.

    METHODS constructor
      IMPORTING scenario TYPE zamp_config_scen-metric_scenario.

    METHODS get_metric_collectors ABSTRACT
      RETURNING VALUE(metric_collectors) TYPE ty_metric_collectors.

    METHODS get_metric_converter ABSTRACT
      RETURNING VALUE(converter_class) TYPE REF TO zif_amp_converter.

  PROTECTED SECTION.

    DATA scenario TYPE zamp_config_scen-metric_scenario.
    DATA metric_collectors TYPE ty_metric_collectors.
    DATA metric_converter_class_name TYPE zamp_config_scen-converter_class.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_amp_customizing IMPLEMENTATION.
  METHOD constructor.

    me->scenario = scenario.

    SELECT SINGLE converter_class
    FROM zamp_config_scen
    INTO @me->metric_converter_class_name
    WHERE metric_scenario = @me->scenario.
    IF sy-subrc <> 0.
      ASSERT 1 = 2.
    ENDIF.

    SELECT *
    FROM zamp_config_prov
    INTO TABLE @metric_collectors
    WHERE metric_scenario = @me->scenario.
    IF sy-subrc <> 0.
      ASSERT 1 = 2.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
