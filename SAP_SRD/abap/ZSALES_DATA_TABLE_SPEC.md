# ZSALES_DATA – Data Dictionary Specification

Create the custom transparent table `ZSALES_DATA` in `SE11`.

| Field | Suggested Type | Key | Description |
|---|---|---:|---|
| VBELN | VBAK-VBELN | Yes | Sales document |
| POSNR | VBAP-POSNR | Yes | Item number |
| KUNNR | VBAK-KUNNR | No | Customer |
| NAME1 | KNA1-NAME1 | No | Customer name |
| MATNR | VBAP-MATNR | No | Material |
| KWMENG | VBAP-KWMENG | No | Order quantity |
| NETWR | VBAP-NETWR | No | Net amount |
| WAERK | VBAK-WAERK | No | Currency |
| ERDAT | VBAK-ERDAT | No | Document date |
| VKORG | VBAK-VKORG | No | Sales organization |

Use data elements/domain references from the SAP system rather than manually inventing DDIC domains. Activate the table before executing the ABAP programs.
