# City of Long Beach Business Licensing Analytics

## About

## Source Datasets

Business licensing data is provided by the City of Long Beach's Financial Management (FM) and Technology & Innovation (TID) departments. We have an internal PostgreSQL database on `clbisandev02`, which serves as the target destination for an ETL to transfer data from the Hansen/LMR system every morning.

The following tables are populated in the `hansen_staging` postgres schema on `clbisandev02` every morning:

| Source Table   	  |  Description |
|---	              |--- |
| business_license  | Primary source of record containing information on all of the business licenses issued and administered by the City. |
| milestone         | A “log” recording change of status for each business license or application by date/time and inspector. |
| notes             | Comments made on a business license application by the inspectors. 
| permit            | Fee descriptions, fee amounts paid or due for each business license (including BID fees). |

The ETLs are maintained by TID's Business Information Systems bureau. The `clbisandev02` server is hosted as an on-premises virtual server maintained by TID's Open Systems group.

## Dissecting the Data

### What is an "Active" business license?

As per Brett Yakus, an **Active** business license is defined by Financial Management (FM) as business licenses that have a status of:
- Active
- CollcInBus
- Expired (might be reactivated or will go into collections)
- Pending
- Reactivate
- Conditionl

Thereby, **Inactive** licenses are those that are not of the above statuses.

### Start Date, Service Date, and Milestone Date

- The **Start Date** for a business license is self-reported by the licensee. The majority of the start dates are the projected opening dates for an establishment.
- The **Service Date** of a business license is... This is also sometime referenced as the "process date".
- The **Milestone Date** column is populated with the last milestone date event corresponding to the **Milestone** column. You can wrangle the milestone events for a license by joining the `business_license` and `milestone` tables. 

### Caveats

- Version 3 of LMR/Hansen for business licensing went online on August 2015. The newest version of Hansen now tracks and records the status of all applications/licenses electronically. The majority of licenses before then were handled by paper. As a result of this, calculations pertaining to Milestones or Permits (like "Days to Issue") are only accurate for licenses after August 2015.
