-- Get all persons
SELECT * FROM Person;

-- Count how many people live in each city
SELECT Ort, COUNT(*) AS Einwohner FROM Person GROUP BY Ort;

-- Find all banks sorted by name
SELECT * FROM Bank ORDER BY Name;


-- Show all employees with their personal details
SELECT p.Vorname, p.Nachname, a.Angestellten_Nr 
FROM Person p
JOIN Angestellter a ON p.Zahl = a.Zahl AND p.Geburtsdatum = a.Geburtsdatum;

-- List all courses with their preparation time in hours
SELECT Kursname, Vorbereitungszeit/60.0 AS Vorbereitungsstunden 
FROM Kurs;


-- Find all participants with their trainers
SELECT 
    t.Kunden_Nr,
    p.Vorname AS Teilnehmer_Vorname,
    p.Nachname AS Teilnehmer_Nachname,
    a.Kennzeichnung AS Trainer_Kennung
FROM Teilnehmer t
JOIN Person p ON t.Zahl = p.Zahl AND t.Geburtsdatum = p.Geburtsdatum
JOIN Ausbilder a ON t.Kennzeichnung = a.Kennzeichnung;

-- Show salary accounts with bank details and employee info
SELECT 
    p.Vorname, p.Nachname,
    b.Name AS Bankname,
    g.Konto_Nr, g.Kontostand
FROM Gehaltskonto g
JOIN Angestellter a ON g.Angestellten_Nr = a.Angestellten_Nr
JOIN Person p ON a.Zahl = p.Zahl AND a.Geburtsdatum = p.Geburtsdatum
JOIN Bank b ON g.Bankleitzahl = b.Bankleitzahl;


-- Update a person's address
UPDATE Person 
SET Straße = 'Neue Straße', Hausnummer = '42' 
WHERE Zahl = 1 AND Geburtsdatum = '1990-05-15';

-- Delete a bank (only if no foreign key constraints are violated)
DELETE FROM Bank WHERE Bankleitzahl = '30000000';



BEGIN;
-- Add a new employee with salary account
INSERT INTO Angestellter (Zahl, Geburtsdatum, Angestellten_Nr)
VALUES (3, '1978-11-03', 1001);

INSERT INTO Gehaltskonto (Angestellten_Nr, Bankleitzahl, Konto_Nr, Kontostand)
VALUES (1001, '10000000', 'DE123456789', 3500.00);
COMMIT;


-- Find employees who earn more than average
SELECT p.Vorname, p.Nachname, g.Kontostand
FROM Gehaltskonto g
JOIN Angestellter a ON g.Angestellten_Nr = a.Angestellten_Nr
JOIN Person p ON a.Zahl = p.Zahl AND a.Geburtsdatum = p.Geburtsdatum
WHERE g.Kontostand > (SELECT AVG(Kontostand) FROM Gehaltskonto);


-- e.g. after teilnehmer insert:
SELECT
    t.kunden_nr,
    p.vorname,
    p.nachname,
    p.zahl || '-' || TO_CHAR(p.geburtsdatum, 'DD.MM.YYYY') AS personenkennzeichen,
    p.plz,
    p.ort,
    p.straße,
    p.hausnummer,
    t.kennzeichnung AS ausbilder_kennzeichnung
FROM
    teilnehmer t
        JOIN
    person p ON t.zahl = p.zahl AND t.geburtsdatum = p.geburtsdatum
ORDER BY
    t.kunden_nr;
