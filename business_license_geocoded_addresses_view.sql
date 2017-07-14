CREATE MATERIALIZED VIEW business_license_geocoded_addresses AS
  SELECT DISTINCT
    bl.stno,
    bl.predir,
    bl.stname,
    bl.suffix,
    geo.longitude,
    geo.latitude
  FROM business_license AS bl
  LEFT JOIN lb_open_addresses AS geo
    ON geo.number = bl.stno
    AND geo.street = TRIM(CONCAT_WS(' ', bl.predir, bl.stname, bl.suffix))
  WHERE
    geo.longitude IS NOT NULL AND
    geo.latitude IS NOT NULL;

CREATE INDEX stno_idx ON business_license_geocoded_addresses (stno);
CREATE INDEX predir_idx ON business_license_geocoded_addresses (predir);
CREATE INDEX stname_idx ON business_license_geocoded_addresses (stname);
CREATE INDEX suffix_idx ON business_license_geocoded_addresses (suffix);