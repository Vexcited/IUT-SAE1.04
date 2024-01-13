SELECT 
    Platform.name AS Platforme, 
    CONCAT(Game.year, "|") AS Année, 
    COUNT(Game.id) AS Jeux
FROM Game
JOIN Platform ON Game.platform_id = Platform.id
WHERE Game.year IS NOT NULL
GROUP BY Platforme, Année
ORDER BY Année