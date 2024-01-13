SELECT 
    Genre.name AS Genre, 
    CASE
        WHEN Game.year BETWEEN 1980 AND 1989 THEN '1980-1989'
        WHEN Game.year BETWEEN 1990 AND 1999 THEN '1990-1999'
        WHEN Game.year BETWEEN 2000 AND 2009 THEN '2000-2009'
        ELSE '2010 et plus'
    END AS Période, 
    COUNT(Game.id) AS Jeux
FROM Game
JOIN Genre ON Game.genre_id = Genre.id
GROUP BY Genre, Période;