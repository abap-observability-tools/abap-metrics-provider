*&---------------------------------------------------------------------*
*& Report zamp_metrics_collector
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zamp_metrics_provider.

PARAMETERS scenario TYPE zamp_config_scen-scenario.

START-OF-SELECTION.

  NEW zcl_amp_strategist( )->provide_metrics( scenario ).
