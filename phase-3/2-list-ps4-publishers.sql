SELECT 
    Publisher.name AS Publisher, 
    SUM(Game.na_sales + Game.eu_sales + Game.jp_sales + Game.other_sales) AS Global_Sales
FROM Game
JOIN Platform ON Game.platform_id = Platform.id
JOIN Publisher ON Game.publisher_id = Publisher.id
WHERE
    -- Jeux PS4
    Platform.name = 'PS4' AND 
    -- Dépassant les 2 millions de jeux vendus quelle que soit l'année.
    (Game.na_sales + Game.eu_sales + Game.jp_sales + Game.other_sales) > 2
GROUP BY 
    Publisher.name
-- Trié par ordre décroissant sur le nombre de jeux vendus.
ORDER BY Global_Sales DESC;
