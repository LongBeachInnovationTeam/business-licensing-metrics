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
