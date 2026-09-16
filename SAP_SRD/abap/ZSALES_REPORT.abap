*&---------------------------------------------------------------------*
*& Report ZSALES_REPORT
*&---------------------------------------------------------------------*
*& Sales Report Dashboard – portfolio reconstruction
*& Data source: ZSALES_DATA
*& Output     : Interactive ALV
*&---------------------------------------------------------------------*
REPORT zsales_report.

TABLES: zsales_data.

SELECT-OPTIONS:
  s_erdat FOR zsales_data-erdat,
  s_kunnr FOR zsales_data-kunnr,
  s_vkorg FOR zsales_data-vkorg.

TYPES: BEGIN OF ty_report,
         vbeln  TYPE zsales_data-vbeln,
         posnr  TYPE zsales_data-posnr,
         kunnr  TYPE zsales_data-kunnr,
         name1  TYPE zsales_data-name1,
         matnr  TYPE zsales_data-matnr,
         kwmeng TYPE zsales_data-kwmeng,
         netwr  TYPE zsales_data-netwr,
         waerk  TYPE zsales_data-waerk,
         erdat  TYPE zsales_data-erdat,
         vkorg  TYPE zsales_data-vkorg,
       END OF ty_report.

DATA: gt_report TYPE STANDARD TABLE OF ty_report,
      gs_report TYPE ty_report,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv.

DATA: gv_total_sales TYPE zsales_data-netwr,
      gv_customer_count TYPE i.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM calculate_summary.
  PERFORM display_alv.

FORM get_data.
  SELECT vbeln,
         posnr,
         kunnr,
         name1,
         matnr,
         kwmeng,
         netwr,
         waerk,
         erdat,
         vkorg
    FROM zsales_data
    WHERE erdat IN @s_erdat
      AND kunnr IN @s_kunnr
      AND vkorg IN @s_vkorg
    INTO TABLE @gt_report.

  IF gt_report IS INITIAL.
    MESSAGE 'No records found for the selected criteria.' TYPE 'I'.
    LEAVE LIST-PROCESSING.
  ENDIF.
ENDFORM.

FORM calculate_summary.
  CLEAR: gv_total_sales, gv_customer_count.

  LOOP AT gt_report INTO gs_report.
    gv_total_sales = gv_total_sales + gs_report-netwr.
  ENDLOOP.

  SORT gt_report BY kunnr.
  DATA(lv_previous_customer) = VALUE zsales_data-kunnr( ).

  LOOP AT gt_report INTO gs_report.
    IF gs_report-kunnr <> lv_previous_customer.
      gv_customer_count = gv_customer_count + 1.
      lv_previous_customer = gs_report-kunnr.
    ENDIF.
  ENDLOOP.

  SORT gt_report BY vbeln posnr.
ENDFORM.

FORM build_fieldcat.
  CLEAR gt_fieldcat.

  PERFORM add_field USING 'VBELN'  'Sales Document'.
  PERFORM add_field USING 'POSNR'  'Item'.
  PERFORM add_field USING 'KUNNR'  'Customer'.
  PERFORM add_field USING 'NAME1'  'Customer Name'.
  PERFORM add_field USING 'MATNR'  'Material'.
  PERFORM add_field USING 'KWMENG' 'Quantity'.
  PERFORM add_field USING 'NETWR'  'Sales Amount'.
  PERFORM add_field USING 'WAERK'  'Currency'.
  PERFORM add_field USING 'ERDAT'  'Document Date'.
  PERFORM add_field USING 'VKORG'  'Sales Organization'.
ENDFORM.

FORM add_field USING pv_field TYPE slis_fieldname
                     pv_text  TYPE char40.
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = pv_field.
  gs_fieldcat-seltext_m = pv_text.
  gs_fieldcat-seltext_l = pv_text.
  APPEND gs_fieldcat TO gt_fieldcat.
ENDFORM.

FORM display_alv.
  PERFORM build_fieldcat.

  DATA(lv_title) = |Sales Dashboard - Total Sales: { gv_total_sales } - Customers: { gv_customer_count }|.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_grid_title            = lv_title
      i_callback_user_command = 'USER_COMMAND'
      it_fieldcat             = gt_fieldcat
      i_save                  = 'A'
    TABLES
      t_outtab                = gt_report
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc <> 0.
    MESSAGE 'ALV display failed.' TYPE 'E'.
  ENDIF.
ENDFORM.

FORM user_command USING pv_ucomm TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.
  CASE pv_ucomm.
    WHEN '&IC1'.
      IF ps_selfield-fieldname = 'VBELN'.
        READ TABLE gt_report INTO gs_report INDEX ps_selfield-tabindex.
        IF sy-subrc = 0.
          MESSAGE |Sales Document { gs_report-vbeln }, Item { gs_report-posnr }, Customer { gs_report-kunnr }| TYPE 'I'.
        ENDIF.
      ENDIF.
  ENDCASE.
ENDFORM.
