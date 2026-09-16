# SAP S/4HANA Sales Report Dashboard

A reconstructed portfolio implementation aligned with the submitted SAP S/4HANA ABAP internship project, **Sales Report Dashboard**.

> **Important:** The original SAP practice-system source code was not available. The ABAP files in this repository are a clean, portfolio-ready reconstruction based on the project report and available screenshots. They should not be represented as the original exported SAP source code.

## Project Overview

The solution extracts sales header, item and customer information from standard SAP tables, stores reporting fields in a custom table `ZSALES_DATA`, processes the data and presents an interactive ALV report.

### Data flow

`VBAK / VBAP / KNA1` → `ZSALES_DATA` → ABAP processing → ALV Sales Report

## SAP Technologies

- SAP S/4HANA
- ABAP
- ABAP List Viewer (ALV)
- SAP Data Dictionary
- SAP GUI
- Open SQL

## Standard SAP Tables

| Table | Purpose |
|---|---|
| VBAK | Sales document header |
| VBAP | Sales document item data |
| KNA1 | Customer master |

## Custom Table: ZSALES_DATA

Suggested fields used by this portfolio implementation:

- `VBELN` – Sales Document
- `POSNR` – Item Number
- `KUNNR` – Customer
- `NAME1` – Customer Name
- `MATNR` – Material
- `KWMENG` – Quantity
- `NETWR` – Net Amount
- `WAERK` – Currency
- `ERDAT` – Document Date
- `VKORG` – Sales Organization

## Report Features

- Date-range selection
- Customer selection
- Sales organization selection
- ALV tabular output
- Sorting and filtering through standard ALV functions
- Total sales calculation
- Customer count
- Customer-wise sales analysis
- Drill-down from sales document to item details
- Excel export through ALV

## SAP Transactions Referenced

- `SE11` – Data Dictionary / custom table
- `SE38` – ABAP report development
- `SE41` – GUI status/menu customization

## Repository Structure

```text
sap-s4hana-sales-report-dashboard/
├── README.md
├── abap/
│   ├── ZSALES_DATA_TABLE_SPEC.md
│   ├── ZSALES_DATA_LOAD.abap
│   └── ZSALES_REPORT.abap
├── documentation/
│   └── architecture.md
├── screenshots/
│   └── README.md
└── sample-data/
    └── README.md
```

## How to Use in SAP

1. Create `ZSALES_DATA` in `SE11` using the field specification in `abap/ZSALES_DATA_TABLE_SPEC.md`.
2. Create and activate the data-load report in `SE38`.
3. Run the loader to populate the custom table from standard SAP sales/customer tables.
4. Create and activate `ZSALES_REPORT` in `SE38`.
5. Execute the report and use the selection screen to filter the output.
6. Use the ALV toolbar for sorting, filtering and export.

## Portfolio Evidence

The submitted project report documents the architecture, methodology, `ZSALES_DATA` design, ALV selection screen, dashboard output, drill-down view and customer transaction report. Screenshots can be placed in the `screenshots/` folder after removing any confidential system/user information.

## Interview Summary

> “I worked on an SAP S/4HANA ABAP sales reporting project. I used VBAK, VBAP and KNA1 as source tables, designed a custom ZSALES_DATA table for reporting, processed the data with ABAP and displayed the results using an interactive ALV report with filtering, aggregation and drill-down.”
