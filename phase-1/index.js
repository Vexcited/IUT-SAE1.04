// On importe les modules pour ouvrir le fichier.
const fs = require("node:fs");
const path = require("node:path");

/**
 * Fonction qui permet de lire un fichier CSV et de le convertir en tableau.
 * Provenant de <https://stackoverflow.com/a/14991797>.
 * 
 * @param {string} str - Le contenu du fichier CSV.
 * @returns {Array<Array<string>>} Un tableau avec les données du fichier CSV.
 */
function parseCSV(str) {
  const arr = [];
  let quote = false;  // 'true' veut dire que l'on est dans un champ entre guillemets

  // On itère sur chaque caractère, on garde en mémoire la ligne et la colonne actuelle (du tableau retourné)
  for (let row = 0, col = 0, c = 0; c < str.length; c++) {
    let cc = str[c], nc = str[c+1];        // Caractère actuel, caractère suivant
    arr[row] = arr[row] || [];             // Créer une nouvelle ligne si nécessaire
    arr[row][col] = arr[row][col] || '';   // Créer une nouvelle colonne si nécessaire (commence par une chaîne vide)

    // Si le caractère actuel est un guillemet, et que l'on est dans un champ entre guillemets,
    // et que le caractère suivant est aussi un guillemet,
    // ajouter un guillemet à la colonne actuelle et passer au caractère suivant.
    if (cc == '"' && quote && nc == '"') { arr[row][col] += cc; ++c; continue; }

    // Si le caractère actuel est un guillemet, on inverse la valeur de la variable 'quote'.
    if (cc == '"') { quote = !quote; continue; }

    // Si le caractère actuel est une virgule et que l'on n'est pas dans un champ entre guillemets,
    // on passe à la colonne suivante.
    if (cc == ',' && !quote) { ++col; continue; }

    // Si le caractère actuel est un retour à la ligne (CRLF) et que l'on n'est pas dans un champ entre guillemets,
    // on passe à la ligne suivante et on passe à la colonne 0 de cette nouvelle ligne.
    if (cc == '\r' && nc == '\n' && !quote) { ++row; col = 0; ++c; continue; }

    // Si le caractère actuel est un retour à la ligne (LF ou CR) et que l'on n'est pas dans un champ entre guillemets,
    // on passe à la ligne suivante et on passe à la colonne 0 de cette nouvelle ligne.
    if (cc == '\n' && !quote) { ++row; col = 0; continue; }
    if (cc == '\r' && !quote) { ++row; col = 0; continue; }

    // Sinon, on ajoute le caractère actuel à la colonne actuelle.
    arr[row][col] += cc;
  }

  return arr;
}

// On lit le fichier CSV qui se trouve dans le même dossier que le script.
const file_path = path.join(__dirname, "vgsales.csv");
const file_raw = fs.readFileSync(file_path, { encoding: "utf-8" });

const rows = parseCSV(file_raw);
const columns = rows.shift();

if (!columns) { // On vérifie que le fichier est correct.
  throw new Error("Le fichier CSV est vide.");
}

// On utilise la première ligne pour déterminer les colonnes.
let sql_query = "INSERT INTO VG_SALES (" + columns.join(",") + ") VALUES ";

for (let row of rows) {
  if (!row) { // On vérifie que la ligne n'est pas vide.
    continue;
  }

  for (let i = 0; i < row.length; i++) {
    row[i] = "'" + row[i].replace(/'/g, "''") + "'";
  }

  // On ajoute la ligne à la requête SQL.
  sql_query += "(" + row.join(",") + "),";
};

// On remplace le dernier caractère par un point-virgule.
sql_query = sql_query.slice(0, -1) + ";";
// On crée le fichier SQL.
fs.writeFileSync(path.join(__dirname, "vgsales.sql"), sql_query, { encoding: "utf-8" });
