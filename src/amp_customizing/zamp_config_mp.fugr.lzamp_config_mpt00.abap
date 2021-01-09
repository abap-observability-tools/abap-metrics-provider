*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 09.01.2021 at 16:42:55
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAMPV_CONFIG_PRO................................*
TABLES: ZAMPV_CONFIG_PRO, *ZAMPV_CONFIG_PRO. "view work areas
CONTROLS: TCTRL_ZAMPV_CONFIG_PRO
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_ZAMPV_CONFIG_PRO. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAMPV_CONFIG_PRO.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAMPV_CONFIG_PRO_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAMPV_CONFIG_PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAMPV_CONFIG_PRO_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAMPV_CONFIG_PRO_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAMPV_CONFIG_PRO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAMPV_CONFIG_PRO_TOTAL.

*...processing: ZAMPV_CONFIG_SCE................................*
TABLES: ZAMPV_CONFIG_SCE, *ZAMPV_CONFIG_SCE. "view work areas
CONTROLS: TCTRL_ZAMPV_CONFIG_SCE
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZAMPV_CONFIG_SCE. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAMPV_CONFIG_SCE.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAMPV_CONFIG_SCE_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAMPV_CONFIG_SCE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAMPV_CONFIG_SCE_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAMPV_CONFIG_SCE_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAMPV_CONFIG_SCE.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAMPV_CONFIG_SCE_TOTAL.

*.........table declarations:.................................*
TABLES: ZAMP_CONFIG_PROV               .
TABLES: ZAMP_CONFIG_SCEN               .
