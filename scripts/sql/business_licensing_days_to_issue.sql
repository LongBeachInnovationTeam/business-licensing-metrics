
CREATE OR REPLACE VIEW days_to_issue_view AS
WITH issue_dates AS (
  WITH first_intake_date AS (
    SELECT DISTINCT
      licenseno,
      MIN(statusdttm) AS license_intake_date
    FROM milestone
    WHERE code = 'Intake'
    GROUP BY licenseno
  )
  SELECT DISTINCT
    milestone.licenseno,
    MIN(statusdttm) AS license_issued_date,
    first_intake_date.license_intake_date
  FROM milestone
  LEFT JOIN first_intake_date ON first_intake_date.licenseno = milestone.licenseno
  WHERE code = 'Issued'
  GROUP BY milestone.licenseno, first_intake_date.license_intake_date
)
SELECT DISTINCT
  bl.*,
  geo.longitude,
  geo.latitude,
  issue_dates.license_issued_date,
  issue_dates.license_intake_date,
  CASE WHEN (issue_dates.license_issued_date::date - issue_dates.license_intake_date::date) = 0
    THEN 1
    ELSE (issue_dates.license_issued_date::date - issue_dates.license_intake_date::date)
  END AS days_to_issue
FROM business_license AS bl
LEFT JOIN issue_dates
  ON issue_dates.licenseno = bl.licenseno
LEFT JOIN business_license_geocoded_addresses AS geo
  ON geo.stno = bl.stno
  AND geo.predir = bl.predir
  AND geo.stname = bl.stname
  AND geo.suffix = bl.suffix;
-- WHERE
--   -- Filter for "Active" business licenses as defined by Brett Yakus and Financial Management
--   bl.licensetype = 'BU' AND
--   bl.licstatus IN ('Active', 'CollcInBus', 'Conditionl', 'Expired', 'Pending', 'Reactivate') AND
--   bl.milestone IN ('Collections', 'Issued', 'Pre-Collections', 'Pre-Renew', 'Renewed');