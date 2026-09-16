# ZSALES_DATA – Data Dictionary Specification

## Overview

`ZSALES_DATA` is a custom transparent table designed for the
SAP S/4HANA Sales Report Dashboard.

The table acts as a simplified reporting structure containing
the sales and customer information required by the ALV report.

The project documentation describes the table as an intermediate
storage layer populated from standard SAP sales and customer tables.

## Source Tables

The custom table is based on relevant fields from:

- `VBAK` – Sales Document Header
- `VBAP` – Sales Document Item
- `KNA1` – Customer Master

## Table Structure

| Field | Reference | Key | Description |
|---|---|---:|---|
| `VBELN` | `VBAK-VBELN` | Yes | Sales document number |
| `POSNR` | `VBAP-POSNR` | Yes | Sales document item |
| `KUNNR` | `VBAK-KUNNR` | No | Customer number |
| `NAME1` | `KNA1-NAME1` | No | Customer name |
| `MATNR` | `VBAP-MATNR` | No | Material number |
| `KWMENG` | `VBAP-KWMENG` | No | Order quantity |
| `NETWR` | `VBAP-NETWR` | No | Net value / sales amount |
| `WAERK` | `VBAK-WAERK` | No | Currency |
| `ERDAT` | `VBAK-ERDAT` | No | Document creation date |
| `VKORG` | `VBAK-VKORG` | No | Sales organization |

## Key Design

The combination of:

`VBELN + POSNR`

is used as the table key to identify an individual
sales-document item.

```text
Sales Document (VBELN)
        +
Item Number (POSNR)
        ↓
Unique Sales Item
