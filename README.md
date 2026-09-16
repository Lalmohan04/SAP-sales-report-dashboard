# SAP S/4HANA Sales Report Dashboard

A backend-driven sales reporting solution developed using SAP S/4HANA ABAP technologies.

The project demonstrates data extraction, processing, custom table design and interactive ALV reporting for analyzing sales and customer information.

---

## Project Overview

The SAP S/4HANA Sales Report Dashboard is designed to transform sales transaction data into structured and user-friendly reports.

The system works with sales and customer information from standard SAP tables, stores the required reporting data in a custom table, processes the data using ABAP and presents the results through an interactive ALV report.

The project focuses on practical implementation of SAP ABAP backend reporting concepts.

---

## Objectives

- Develop a backend-driven sales reporting solution using SAP S/4HANA ABAP.
- Extract relevant sales and customer information from standard SAP tables.
- Design a custom reporting table for structured data storage.
- Process and aggregate sales information using ABAP.
- Develop an interactive ALV report for business-oriented analysis.
- Support filtering, sorting, drill-down and Excel export functionality.

---

## Technologies Used

| Technology / Tool | Purpose |
|---|---|
| SAP S/4HANA | Enterprise application platform |
| ABAP | Data extraction and business logic |
| ALV | Interactive report presentation |
| SE11 | Data Dictionary and table management |
| SE38 | ABAP program development and execution |
| SE41 | GUI status/menu configuration |
| Open SQL | Database data retrieval |

---

## SAP Standard Tables

The project uses the following standard SAP tables as data sources:

### VBAK – Sales Document Header

Contains sales document header information such as:

- Sales document number
- Customer
- Sales organization
- Document date
- Currency

### VBAP – Sales Document Item

Contains item-level information such as:

- Item number
- Material
- Quantity
- Net value

### KNA1 – Customer Master

Provides customer master information including customer name.

---

## Custom Table

### ZSALES_DATA

A custom transparent table is used as the reporting data structure.

The table contains relevant fields from the standard SAP sales and customer tables.

| Field | Description |
|---|---|
| VBELN | Sales document |
| POSNR | Item number |
| KUNNR | Customer |
| NAME1 | Customer name |
| MATNR | Material |
| KWMENG | Order quantity |
| NETWR | Net amount |
| WAERK | Currency |
| ERDAT | Document date |
| VKORG | Sales organization |

The combination of `VBELN` and `POSNR` identifies an individual sales-document item.

Detailed table documentation is available in:

[`documentation/ZSALES_DATA_TABLE_SPEC.md`]( SAP_SRD/documentation/ZSALES_DATA_TABLE_SPEC.md)

---

## System Architecture

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
