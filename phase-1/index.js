// @ts-check

const fs = require("node:fs");
const path = require("node:path");

const file_path = path.join(__dirname, "vgsales.csv");
const file_raw = fs.readFileSync(file_path, { encoding: "utf-8" });

/** @type {Array<Record<string, string>>} */
const results = [];
/** @type {Array<string>} */
let columns = [];

let line_index = 0;
for (const line of file_raw.split("\n")) {
  if (line_index === 0) {
    columns = line.split(",")
    line_index++;
    continue;
  }
  
  /** @type {Record<string, string>} */
  const result = {};

  const values = line.split(",");
  for (let i = 0; i < columns.length; i++) {
    result[columns[i]] = values[i];
  }
  
  results.push(result);
  line_index++;
};

// TODO
console.log(results);
console.log(results.length);
