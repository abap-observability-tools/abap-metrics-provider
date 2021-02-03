*&---------------------------------------------------------------------*
*& Report zamp_metrics_collector
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zamp_metrics_provider.

PARAMETERS scenario TYPE zamp_config_scen-metric_scenario.

START-OF-SELECTION.

  IF NEW zcl_amp_auth_checker( )->is_providing_allowed( ) = abap_true.
    NEW zcl_amp_strategist( )->provide_metrics( scenario ).
  ELSE.
    MESSAGE 'no authority' TYPE 'E'.
  ENDIF.
