-- Insert sample persons
INSERT INTO Person (Zahl, Geburtsdatum, Vorname, Nachname, PLZ, Ort, Straße, Hausnummer)
VALUES
    (1, '1990-05-15', 'Max', 'Mustermann', '10115', 'Berlin', 'Hauptstraße', '12'),
    (2, '1985-08-22', 'Anna', 'Schmidt', '20095', 'Hamburg', 'Mönckebergstraße', '5'),
    (3, '1978-11-03', 'Thomas', 'Müller', '80331', 'München', 'Marienplatz', '1');

-- Insert banks
INSERT INTO Bank (Bankleitzahl, Name)
VALUES
    ('10000000', 'Berliner Sparkasse'),
    ('20000000', 'Hamburger Volksbank'),
    ('30000000', 'Bayerische Landesbank');

-- Insert courses
INSERT INTO Kurs (Kursname, Anzahl_Organisatoren, Vorbereitungszeit)
VALUES
    ('Datenbanken', 2, 30),
    ('Programmierung', 3, 45),
    ('Webentwicklung', 1, 20);

