CREATE MATERIALIZED VIEW vw_period_movements AS
  (SELECT
     uuid_in(md5(random() :: TEXT || now() :: TEXT) :: cstring) AS uuid,

     periodStart,
     periodEnd,

     facilities.name                                            AS facility_name,
     products.primaryname                                       AS drug_name,
     facilities.code                                            AS facility_code,
     products.code                                              AS drug_code,
     parent_zone.name                                           AS province_name,
     parent_zone.code                                           AS province_code,
     ZONE.name                                                  AS district_name,
     ZONE.code                                                  AS district_code,

     soh_of_day(stockcardid, periodEnd :: DATE) :: INTEGER      AS soh,
     cmm_of(stockcardid, periodStart, periodEnd)                AS cmm,

     (total_quantity_and_occurrences(stockcardid, periodStart,
                                     periodEnd)).*

   FROM (SELECT
           startdate                            AS periodStart,
           enddate                              AS periodEnd,
           existing_card_ids_in_period(enddate) AS stockcardid
         FROM processing_periods) AS cardIdsInPeriods
     JOIN stock_cards ON cardIdsInPeriods.stockcardid = stock_cards.id
     JOIN facilities ON stock_cards.facilityid = facilities.id
     JOIN products ON stock_cards.productid = products.id
     JOIN geographic_zones AS ZONE
       ON facilities.geographiczoneid = ZONE.id
     JOIN geographic_zones AS parent_zone
       ON ZONE.parentid = parent_zone.id);

CREATE UNIQUE INDEX idx_vw_period_movements ON vw_period_movements (uuid,periodStart,periodEnd,facility_code);