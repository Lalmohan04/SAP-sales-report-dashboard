*&---------------------------------------------------------------------*
*& Report ZSALES_DATA_LOAD
*&---------------------------------------------------------------------*
*& Portfolio reconstruction of the data extraction/population layer.
*& Source tables: VBAK, VBAP, KNA1
*& Target table : ZSALES_DATA
*&---------------------------------------------------------------------*
REPORT zsales_data_load.

TABLES: vbak, vbap.

SELECT-OPTIONS:
  s_erdat FOR vbak-erdat,
  s_kunnr FOR vbak-kunnr,
  s_vkorg FOR vbak-vkorg.

TYPES: BEGIN OF ty_source,
         vbeln  TYPE vbak-vbeln,
         posnr  TYPE vbap-posnr,
         kunnr  TYPE vbak-kunnr,
         name1  TYPE kna1-name1,
         matnr  TYPE vbap-matnr,
         kwmeng TYPE vbap-kwmeng,
         netwr  TYPE vbap-netwr,
         waerk  TYPE vbak-waerk,
         erdat  TYPE vbak-erdat,
         vkorg  TYPE vbak-vkorg,
       END OF ty_source.

DATA: gt_source TYPE STANDARD TABLE OF ty_source,
      gs_source TYPE ty_source,
      gs_sales  TYPE zsales_data.

START-OF-SELECTION.

  SELECT a~vbeln,
         b~posnr,
         a~kunnr,
         c~name1,
         b~matnr,
         b~kwmeng,
         b~netwr,
         a~waerk,
         a~erdat,
         a~vkorg
    FROM vbak AS a
    INNER JOIN vbap AS b
      ON b~vbeln = a~vbeln
    LEFT OUTER JOIN kna1 AS c
      ON c~kunnr = a~kunnr
    WHERE a~erdat IN @s_erdat
      AND a~kunnr IN @s_kunnr
      AND a~vkorg IN @s_vkorg
    INTO TABLE @gt_source.

  IF gt_source IS INITIAL.
    MESSAGE 'No sales records found for the selected criteria.' TYPE 'I'.
    RETURN.
  ENDIF.

  LOOP AT gt_source INTO gs_source.
    CLEAR gs_sales.
    MOVE-CORRESPONDING gs_source TO gs_sales.
    MODIFY zsales_data FROM @gs_sales.
  ENDLOOP.

  COMMIT WORK AND WAIT.

  MESSAGE |{ lines( gt_source ) } sales item records loaded into ZSALES_DATA.| TYPE 'S'.
