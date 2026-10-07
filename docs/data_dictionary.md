# Analytics Data Dictionary

## Overview

The `analytics` schema contains the dimensional model Power BI uses.

The model contains:

- Five dimensions describing patients, providers, organizations, payers, and conditions
- One encounter fact table
- One condition-occurrence fact table

## Table Summary

| Table | Type | Grain | Description |
|---|---|---|---|
| `analytics.dim_patient` | Dimension | One row per patient | Patient demographics and location |
| `analytics.dim_provider` | Dimension | One row per provider | Provider identity, specialty and location |
| `analytics.dim_organization` | Dimension | One row per organization | Healthcare organization details |
| `analytics.dim_payer` | Dimension | One row per payer | Insurance payer details |
| `analytics.dim_condition` | Dimension | One row per condition code | Condition codes and descriptions |
| `analytics.fact_encounter` | Fact | One row per encounter | Encounter activity, relationships and costs |
| `analytics.fact_condition` | Fact | One row per recorded condition occurrence | Conditions recorded for patients during encounters |

---

## analytics.dim_patient

| Column | Description |
|---|---|
| `patient_key` | Warehouse-generated surrogate key used by fact tables |
| `patient_id` | Original patient UUID from Synthea |
| `birth_date` | Patient date of birth |
| `death_date` | Patient date of death, when applicable |
| `first_name` | Patient first name |
| `last_name` | Patient last name |
| `maiden_name` | Patient maiden name, when applicable |
| `marital_status` | Standardized marital status |
| `race` | Patient race |
| `ethnicity` | Patient ethnicity |
| `gender` | Standardized patient gender |
| `birthplace` | Patient birthplace |
| `city` | Patient city |
| `state` | Patient state |
| `county` | Patient county |
| `zip_code` | Patient postal code |
| `latitude` | Patient-location latitude |
| `longitude` | Patient-location longitude |
| `dwh_create_date` | Date and time the warehouse row was created |

## analytics.dim_provider

| Column | Description |
|---|---|
| `provider_key` | Warehouse-generated surrogate key |
| `provider_id` | Original provider UUID |
| `provider_name` | Provider name |
| `gender` | Standardized provider gender |
| `specialty` | Provider medical specialty |
| `address` | Provider address |
| `city` | Provider city |
| `state` | Provider state |
| `zip_code` | Provider postal code |
| `latitude` | Provider-location latitude |
| `longitude` | Provider-location longitude |
| `dwh_create_date` | Date and time the warehouse row was created |

## analytics.dim_organization

| Column | Description |
|---|---|
| `organization_key` | Warehouse-generated surrogate key |
| `organization_id` | Original organization UUID |
| `organization_name` | Healthcare organization name |
| `address` | Organization address |
| `city` | Organization city |
| `state` | Organization state |
| `zip_code` | Organization postal code |
| `latitude` | Organization-location latitude |
| `longitude` | Organization-location longitude |
| `phone` | Organization telephone number |
| `dwh_create_date` | Date and time the warehouse row was created |

## analytics.dim_payer

| Column | Description |
|---|---|
| `payer_key` | Warehouse-generated surrogate key |
| `payer_id` | Original payer UUID |
| `payer_name` | Insurance payer name |
| `address` | Payer address |
| `city` | Payer city |
| `headquarters_state` | State containing the payer’s headquarters |
| `zip_code` | Payer postal code |
| `phone` | Payer telephone number |
| `dwh_create_date` | Date and time the warehouse row was created |

## analytics.dim_condition

| Column | Description |
|---|---|
| `condition_key` | Warehouse-generated surrogate key |
| `condition_code` | Original condition code |
| `condition_description` | Description of the recorded condition |
| `dwh_create_date` | Date and time the warehouse row was created |

A condition represents a condition record associated with an encounter. It is
not necessarily the primary reason for that encounter.

## analytics.fact_encounter

**Grain:** One row represents one healthcare encounter.

| Column | Description |
|---|---|
| `encounter_id` | Original encounter UUID and primary key |
| `patient_key` | Links the encounter to `dim_patient` |
| `provider_key` | Links the encounter to `dim_provider` |
| `organization_key` | Links the encounter to `dim_organization` |
| `payer_key` | Links the encounter to `dim_payer` |
| `encounter_start` | Encounter starting date and time |
| `encounter_stop` | Encounter ending date and time |
| `encounter_date` | Date portion of `encounter_start` |
| `encounter_class` | Standardized encounter category |
| `encounter_code` | Encounter code |
| `encounter_description` | Encounter description |
| `base_encounter_cost` | Base cost before additional line items |
| `total_claim_cost` | Total encounter cost including associated line items |
| `payer_coverage` | Amount covered by the payer |
| `patient_responsibility` | Total cost minus payer coverage |
| `reason_code` | Code describing the encounter reason, when recorded |
| `reason_description` | Description of the encounter reason |
| `dwh_create_date` | Date and time the warehouse row was created |

## analytics.fact_condition

**Grain:** One row represents one recorded condition occurrence.

| Column | Description |
|---|---|
| `condition_occurrence_key` | Warehouse-generated identifier for the occurrence |
| `patient_key` | Links the occurrence to `dim_patient` |
| `condition_key` | Links the occurrence to `dim_condition` |
| `encounter_id` | Encounter associated with the condition record |
| `condition_start_date` | Date the condition was recorded |
| `condition_stop_date` | Date the condition ended, when applicable |
| `dwh_create_date` | Date and time the warehouse row was created |

Multiple condition occurrences can belong to one encounter. The dashboard
therefore uses distinct encounter counts when comparing recorded conditions.

---

## Power BI Measures

| Measure | Definition |
|---|---|
| `Total Encounters` | Distinct count of encounter IDs |
| `Total Encounter Cost` | Sum of `total_claim_cost` |
| `Average Cost per Encounter` | Total encounter cost divided by total encounters |
| `Unique Patients` | Distinct count of patients represented in encounters |
| `Encounters With Condition` | Distinct count of encounter IDs in `fact_condition` |
| `Active Patients` | Patients with at least one encounter in the selected period |
| `Encounters per Active Patient` | Total encounters divided by active patients |

## Data Source

The project uses synthetic patient data generated by
[Synthea](https://github.com/synthetichealth/synthea).
