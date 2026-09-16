# Architecture

```text
+-----------------------------+
| SAP GUI / ALV Selection     |
| Date | Customer | VKORG     |
+-------------+---------------+
              |
              v
+-----------------------------+
| ABAP Data Extraction        |
| ZSALES_DATA_LOAD            |
+-------------+---------------+
              |
              v
+-----------------------------+
| Standard SAP Tables         |
| VBAK | VBAP | KNA1          |
+-------------+---------------+
              |
              v
+-----------------------------+
| Custom Reporting Table      |
| ZSALES_DATA                 |
+-------------+---------------+
              |
              v
+-----------------------------+
| ABAP Processing             |
| totals / customer analysis  |
+-------------+---------------+
              |
              v
+-----------------------------+
| Interactive ALV Report      |
| sort / filter / export      |
| drill-down                  |
+-----------------------------+
```
