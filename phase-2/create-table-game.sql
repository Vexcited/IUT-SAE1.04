CREATE TABLE Game (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(1024) NOT NULL, -- Nom du jeu.
    platform_id INT NOT NULL,
    year NUMERIC(4) NULL, -- Une année correspond à 4 chiffres. NULL lorsque "N/A"
    publisher_id INT NULL, -- NULL lorsque "N/A" ou "Unknown".
    na_sales DECIMAL(4, 2) NOT NULL, -- Ventes en Amérique du Nord.
    eu_sales DECIMAL(4, 2) NOT NULL, -- Ventes en Europe.
    jp_sales DECIMAL(4, 2) NOT NULL, -- Ventes au Japon.
    other_sales DECIMAL(4, 2) NOT NULL, -- Autres ventes.
    genre_id INT NOT NULL, -- Genre du jeu.

    FOREIGN KEY (platform_id) REFERENCES Platform(id),
    FOREIGN KEY (publisher_id) REFERENCES Publisher(id),
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);
