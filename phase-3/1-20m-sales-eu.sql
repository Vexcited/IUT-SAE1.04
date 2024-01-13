SELECT Platform.name FROM Game
JOIN Platform ON Game.platform_id = Platform.id
-- Depuis 2010.
WHERE Game.year >= 2010
-- Liste des plateformes.
GROUP BY Game.platform_id
-- Ayant plus de 20 millions de jeux vendus en Europe.
HAVING SUM(Game.eu_sales) > 20;
