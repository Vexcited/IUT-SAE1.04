SELECT 
    Genre.name AS Genre, 
    Game.year - 2000 AS Période, 
    SUM(Game.na_sales) AS Ventes
FROM Game
JOIN Genre ON Game.genre_id = Genre.id
WHERE Game.year BETWEEN 2000 AND 2010
GROUP BY Genre, Période;