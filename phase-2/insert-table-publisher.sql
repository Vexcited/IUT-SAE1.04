INSERT INTO Publisher (name)
SELECT DISTINCT Publisher FROM VG_SALES
WHERE Publisher != "N/A" AND Publisher != "Unknown";