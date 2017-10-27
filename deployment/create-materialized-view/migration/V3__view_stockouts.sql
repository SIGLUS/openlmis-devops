DROP MATERIALIZED VIEW vw_stockouts;

CREATE MATERIALIZED VIEW vw_stockouts AS
  SELECT
    uuid_in(md5(random() :: TEXT || now() :: TEXT) :: cstring) AS uuid,

    facilities.name             AS facility_name,
    facilities.code             AS facility_code,
    zone.name                   AS district_name,
    zone.code                   AS district_code,
    parent_zone.name            AS province_name,
    parent_zone.code            AS province_code,
    products.code               AS drug_code,
    products.primaryname        AS drug_name,
    programs.name               AS program,
    stock_card_entries.occurred AS stockout_date,
    (calculate_each_month_duration(stock_cards.id, stock_card_entries.occurred, stockcardentryid)).*
  FROM facilities
    JOIN geographic_zones AS zone ON facilities.geographiczoneid = zone.id
    JOIN geographic_zones AS parent_zone ON zone.parentid = parent_zone.id
    JOIN stock_cards ON facilities.id = stock_cards.facilityid
    JOIN products ON stock_cards.productid = products.id
    JOIN program_products ON products.id = program_products.productid
    JOIN programs ON program_products.programid = programs.id
    JOIN stock_card_entries ON stock_cards.id = stock_card_entries.stockcardid
    JOIN stock_card_entry_key_values ON stock_card_entries.id = stock_card_entry_key_values.stockcardentryid
  WHERE keycolumn = 'soh' AND valuecolumn = '0' AND stock_card_entries.quantity != 0
  ORDER BY facility_code, drug_code, stockout_date, overlapped_month, stockcardentryid;

CREATE UNIQUE INDEX idx_vw_stockouts ON vw_stockouts (uuid);
