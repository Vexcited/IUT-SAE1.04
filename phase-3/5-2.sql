SELECT
    ge.name as Genre,
    p.name AS Éditeur,
    SUM(g.na_sales + g.eu_sales + g.jp_sales + g.other_sales) AS Ventes
FROM Game g
JOIN Publisher p ON g.publisher_id = p.id
JOIN Genre ge ON g.genre_id = ge.id
-- On ne considère que les jeux dont l'éditeur est connu.
WHERE g.publisher_id IS NOT NULL
-- On regroupe par genre et éditeur.
GROUP BY g.genre_id, p.id, p.name
HAVING -- Similaire à WHERE mais pour les colonnes calculées.
    Ventes = (
        SELECT MAX(total_sales_per_genre)
        FROM
            (
                SELECT
                    g.name,
                    g.genre_id,
                    SUM(g.na_sales + g.eu_sales + g.jp_sales + g.other_sales) AS total_sales_per_genre
                FROM Game g
                JOIN Publisher p ON g.publisher_id = p.id
                WHERE g.publisher_id IS NOT NULL
                GROUP BY g.genre_id, p.id
            ) AS max_sales_per_genre
        WHERE max_sales_per_genre.genre_id = g.genre_id
    )
ORDER BY Ventes DESC;