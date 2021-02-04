*&---------------------------------------------------------------------*
*& Report zamp_clear_zamp_store
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zamp_clear_zamp_store.

IF NEW zcl_amp_auth_checker( )->is_deleting_allowed( ) = abap_true.
  DELETE FROM zamp_store.
ELSE.
  MESSAGE 'no authority' TYPE 'E'.
ENDIF.
