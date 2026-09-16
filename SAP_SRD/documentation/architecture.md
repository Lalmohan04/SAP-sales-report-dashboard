# Architecture

```text
+-----------------------------+
| Standard SAP Tables         |
| VBAK | VBAP | KNA1          |
| Sales & Customer Data       |
+-------------+---------------+
              |
              v
+-----------------------------+
| ABAP Data Extraction        |
| ZSALES_DATA_LOAD            |
| Select / Join / Map Data    |
+-------------+---------------+
              |
              v
+-----------------------------+
| Custom Reporting Table      |
| ZSALES_DATA                 |
| Structured Sales Data       |
+-------------+---------------+
              |
              v
+-----------------------------+
| ABAP Processing             |
| Totals / Aggregation        |
| Customer-wise Analysis      |
+-------------+---------------+
              |
              v
+-----------------------------+
| ALV Selection Screen        |
| Date | Customer | VKORG     |
+-------------+---------------+
              |
              v
+-----------------------------+
| Interactive ALV Report      |
| Sort | Filter | Export      |
| Drill-down                  |
+-----------------------------+
