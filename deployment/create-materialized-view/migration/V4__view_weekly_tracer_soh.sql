CREATE MATERIALIZED VIEW vw_weekly_tracer_soh AS
(SELECT
 uuid_in(md5(random() :: TEXT || now() :: TEXT) :: cstring) AS uuid,
 *
 FROM tracer_drugs_weekly_stock_history());

CREATE UNIQUE INDEX idx_vw_weekly_tracer_soh ON vw_weekly_tracer_soh (uuid);