INSERT INTO products (code, primaryName, dispensingUnit, dosesPerDispensingUnit, packSize, active, fullSupply, tracer, packRoundingThreshold, roundToZero, strength, formId, isKit)
SELECT 'SCOD10-AL', 'KITS  (DE PME US AL)180 TREATMENT', 'KIT', 1, 1, TRUE, TRUE, FALSE, 0, FALSE, '180', (SELECT id from product_forms where code='KIT'), TRUE
WHERE
    NOT EXISTS (
        SELECT code FROM products WHERE code = 'SCOD10-AL'
    );

INSERT INTO products (code, primaryName, dispensingUnit, dosesPerDispensingUnit, packSize, active, fullSupply, tracer, packRoundingThreshold, roundToZero, strength, formId, isKit)
SELECT 'SCOD12-AL', 'KITS  (DE PME APE AL)75 TREATMENT', 'KIT', 1, 1, TRUE, TRUE, FALSE, 0, FALSE, '75', (SELECT id from product_forms where code='KIT'), TRUE
WHERE
    NOT EXISTS (
        SELECT code FROM products WHERE code = 'SCOD12-AL'
    );

INSERT INTO program_products (programId, productId, fullSupply, active, dosesPerMonth, productCategoryId, currentPrice, displayOrder)
SELECT (SELECT id FROM programs WHERE code = 'ESS_MEDS'), (SELECT id FROM products WHERE code = 'SCOD10-AL'), TRUE, TRUE,12.5, (SELECT id FROM product_categories where code = '11'), 0.0,  14
WHERE
    NOT EXISTS (
        SELECT * FROM program_products LEFT JOIN products ON products.id = productId LEFT JOIN programs ON programs.id = programId WHERE products.code = 'SCOD10-AL' AND programs.code = 'ESS_MEDS'
    );

INSERT INTO program_products (programId, productId, fullSupply, active, dosesPerMonth, productCategoryId, currentPrice, displayOrder)
SELECT (SELECT id FROM programs WHERE code = 'ESS_MEDS'), (SELECT id FROM products WHERE code = 'SCOD12-AL'), TRUE, TRUE,12.5, (SELECT id FROM product_categories where code = '11'), 0.0,  14
WHERE
    NOT EXISTS (
        SELECT * FROM program_products LEFT JOIN products ON products.id = productId LEFT JOIN programs ON programs.id = programId WHERE products.code = 'SCOD12-AL' AND programs.code = 'ESS_MEDS'
    );

INSERT INTO facility_approved_products (facilityTypeId, programProductId, maxMonthsOfStock)
SELECT (SELECT id FROM facility_types WHERE code = 'CSRUR-I'),(SELECT id FROM program_products WHERE productId = (SELECT id FROM products WHERE code = 'SCOD10-AL')), 1
WHERE
    NOT EXISTS (
        SELECT * FROM facility_approved_products LEFT JOIN facility_types f ON f.id = facilityTypeId LEFT JOIN program_products pp ON pp.id = programProductId LEFT JOIN products p ON p.id = pp.productId WHERE f.code = 'CSRUR-I' AND p.code = 'SCOD10-AL'
    );

INSERT INTO facility_approved_products (facilityTypeId, programProductId, maxMonthsOfStock)
SELECT (SELECT id FROM facility_types WHERE code = 'CSRUR-II'),(SELECT id FROM program_products WHERE productId = (SELECT id FROM products WHERE code = 'SCOD10-AL')), 1
WHERE
    NOT EXISTS (
        SELECT * FROM facility_approved_products LEFT JOIN facility_types f ON f.id = facilityTypeId LEFT JOIN program_products pp ON pp.id = programProductId LEFT JOIN products p ON p.id = pp.productId WHERE f.code = 'CSRUR-II' AND p.code = 'SCOD10-AL'
    );

INSERT INTO facility_approved_products (facilityTypeId, programProductId, maxMonthsOfStock)
SELECT (SELECT id FROM facility_types WHERE code = 'CSRUR-I'),(SELECT id FROM program_products WHERE productId = (SELECT id FROM products WHERE code = 'SCOD12-AL')), 1
WHERE
    NOT EXISTS (
        SELECT * FROM facility_approved_products LEFT JOIN facility_types f ON f.id = facilityTypeId LEFT JOIN program_products pp ON pp.id = programProductId LEFT JOIN products p ON p.id = pp.productId WHERE f.code = 'CSRUR-I' AND p.code = 'SCOD12-AL'
    );

INSERT INTO facility_approved_products (facilityTypeId, programProductId, maxMonthsOfStock)
SELECT (SELECT id FROM facility_types WHERE code = 'CSRUR-II'),(SELECT id FROM program_products WHERE productId = (SELECT id FROM products WHERE code = 'SCOD12-AL')), 1
WHERE
    NOT EXISTS (
        SELECT * FROM facility_approved_products LEFT JOIN facility_types f ON f.id = facilityTypeId LEFT JOIN program_products pp ON pp.id = programProductId LEFT JOIN products p ON p.id = pp.productId WHERE f.code = 'CSRUR-II' AND p.code = 'SCOD12-AL'
    );


INSERT INTO kit_products_relation (kitCode, productCode, quantity)
SELECT 'SCOD10-AL', '08O05', 60
WHERE
    NOT EXISTS (
        SELECT * FROM kit_products_relation WHERE kitCode = 'SCOD10-AL' AND productCode = '08O05'
    );

INSERT INTO kit_products_relation (kitCode, productCode, quantity)
SELECT 'SCOD10-AL', '08O05Z', 30
WHERE
    NOT EXISTS (
        SELECT * FROM kit_products_relation WHERE kitCode = 'SCOD10-AL' AND productCode = '08O05Z'
    );

INSERT INTO kit_products_relation (kitCode, productCode, quantity)
SELECT 'SCOD10-AL', '08O05Y', 20
WHERE
    NOT EXISTS (
        SELECT * FROM kit_products_relation WHERE kitCode = 'SCOD10-AL' AND productCode = '08O05Y'
    );

INSERT INTO kit_products_relation (kitCode, productCode, quantity)
SELECT 'SCOD10-AL', '08O05X', 60
WHERE
    NOT EXISTS (
        SELECT * FROM kit_products_relation WHERE kitCode = 'SCOD10-AL' AND productCode = '08O05X'
    );

INSERT INTO kit_products_relation (kitCode, productCode, quantity)
SELECT 'SCOD10-AL', '22A08', 14
WHERE
    NOT EXISTS (
        SELECT * FROM kit_products_relation WHERE kitCode = 'SCOD10-AL' AND productCode = '22A08'
    );