-- INSERT INTO Game (name, platform_id, year, publisher_id, na_sales, eu_sales, jp_sales, other_sales, genre_id)
SELECT
    VG_SALES.Name as name,
    Platform.id as platform_id,
    NULLIF(VG_SALES.Year, "N/A") as year,
    Publisher.id as publisher_id,
    CONVERT(NA_Sales, DECIMAL(4, 2)) as na_sales,
    CONVERT(EU_Sales, DECIMAL(4, 2)) as eu_sales,
    CONVERT(JP_Sales, DECIMAL(4, 2)) as jp_sales,
    CONVERT(Other_Sales, DECIMAL(4, 2)) as other_sales,
    Genre.id as genre_id
FROM VG_SALES
JOIN Platform ON VG_SALES.Platform = Platform.name
LEFT JOIN Publisher ON VG_SALES.Publisher = Publisher.name
JOIN Genre ON VG_SALES.Genre = Genre.name;

-- NAME:         SELECT Name as name FROM VG_SALES;
-- PLATFORM_ID:  SELECT Platform.id as platform_id FROM VG_SALES JOIN Platform ON VG_SALES.Platform = Platform.name;
-- YEAR:         SELECT NULLIF(Year, "N/A") as year FROM VG_SALES;
-- PUBLISHER_ID: SELECT Publisher.id as publisher_id FROM VG_SALES
--               LEFT JOIN Publisher ON VG_SALES.Publisher = Publisher.name;
-- SALES:        SELECT CONVERT(NA_Sales, DECIMAL(4, 2)) as na_sales, CONVERT(EU_Sales, DECIMAL(4, 2)) as eu_sales, CONVERT(JP_Sales, DECIMAL(4, 2)) as jp_sales, CONVERT(Other_Sales, DECIMAL(4, 2)) as other_sales FROM VG_SALES;
-- GENRE_ID:     SELECT Genre.id as genre_id FROM VG_SALES JOIN Genre ON VG_SALES.Genre = Genre.name;
