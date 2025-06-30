-- Data Insertion Script
-- Note: Execute schema.sql first, then this file

-- Insert data into Person table
INSERT INTO Person (Zahl, Geburtsdatum, Vorname, Nachname, PLZ, Ort, Straße, Hausnummer)
VALUES
    (1, '1980-05-15', 'Max', 'Mustermann', '10115', 'Berlin', 'Hauptstraße', '12'),
    (2, '1975-08-22', 'Anna', 'Schmidt', '80331', 'München', 'Bahnhofstraße', '5'),
    (3, '1990-03-10', 'Thomas', 'Müller', '50667', 'Köln', 'Domplatz', '1'),
    (4, '1985-11-30', 'Sarah', 'Wagner', '20144', 'Hamburg', 'Jungfernstieg', '25'),
    (5, '1978-07-04', 'Michael', 'Becker', '70173', 'Stuttgart', 'Königstraße', '10'),
    (6, '1992-01-18', 'Laura', 'Hoffmann', '60311', 'Frankfurt', 'Zeil', '112'),
    (7, '1983-09-25', 'Daniel', 'Schulz', '01067', 'Dresden', 'Prager Straße', '8'),
    (8, '1970-12-05', 'Julia', 'Koch', '04109', 'Leipzig', 'Nikolaistraße', '3'),
    (9, '1987-04-12', 'David', 'Bauer', '38100', 'Braunschweig', 'Bohlweg', '45'),
    (10, '1995-06-28', 'Sophie', 'Richter', '39104', 'Magdeburg', 'Breiter Weg', '30');

-- Insert data into Bank table
INSERT INTO Bank (Bankleitzahl, Name)
VALUES
    ('10000000', 'Deutsche Bank'),
    ('20000000', 'Commerzbank'),
    ('30000000', 'Sparkasse'),
    ('40000000', 'Volksbank'),
    ('50000000', 'Postbank');

-- Insert data into Kurs table
INSERT INTO Kurs (Kursname, Anzahl_Organisatoren, Vorbereitungszeit)
VALUES
    ('Grundlagen der Programmierung', 2, 30),
    ('Datenbanken', 3, 45),
    ('Webentwicklung', 2, 40),
    ('Maschinelles Lernen', 4, 60),
    ('Projektmanagement', 2, 35);

-- Insert data into Telefonnummer table
INSERT INTO Telefonnummer (Zahl, Geburtsdatum, Nummer)
VALUES
    (1, '1980-05-15', '+49 17612345678'),
    (2, '1975-08-22', '+49 15198765432'),
    (3, '1990-03-10', '+49 1705556677'),
    (4, '1985-11-30', '+49 1723334444'),
    (5, '1978-07-04', '+49 1607778888'),
    (6, '1992-01-18', '+49 1789990000'),
    (7, '1983-09-25', '+49 1521112222'),
    (8, '1970-12-05', '+49 1773334444'),
    (9, '1987-04-12', '+49 1795556666'),
    (10, '1995-06-28', '+49 1747778888');

-- Insert data into Angestellter table
INSERT INTO Angestellter (Zahl, Geburtsdatum, Angestellten_Nr)
VALUES
    (1, '1980-05-15', 1001),
    (2, '1975-08-22', 1002),
    (3, '1990-03-10', 1003),
    (4, '1985-11-30', 1004),
    (5, '1978-07-04', 1005);

-- Insert data into Gehaltskonto table
INSERT INTO Gehaltskonto (Angestellten_Nr, Bankleitzahl, Konto_Nr, Kontostand)
VALUES
    (1001, '10000000', 'DE12345678901234567890', 5000.00),
    (1002, '20000000', 'DE98765432109876543210', 6500.00),
    (1003, '30000000', 'DE11112222333344445555', 4500.00),
    (1004, '40000000', 'DE55554444333322221111', 7000.00),
    (1005, '50000000', 'DE99998888777766665555', 6000.00);

-- Insert data into Ausbilder table
INSERT INTO Ausbilder (Angestellten_Nr, Einstellungsdatum, Kennzeichnung)
VALUES
    (1001, '2010-06-01', 'AUSB-001'),
    (1002, '2012-03-15', 'AUSB-002'),
    (1003, '2015-09-10', 'AUSB-003');

-- Insert data into Teilnehmer table
INSERT INTO Teilnehmer (Zahl, Geburtsdatum, Kunden_Nr, Kennzeichnung)
VALUES
    (6, '1992-01-18', 2001, 'AUSB-001'),
    (7, '1983-09-25', 2002, 'AUSB-002'),
    (8, '1970-12-05', 2003, 'AUSB-003'),
    (9, '1987-04-12', 2004, 'AUSB-001'),
    (10, '1995-06-28', 2005, 'AUSB-002');

-- Insert data into Ausbilder_hasst_Ausbilder table
INSERT INTO Ausbilder_hasst_Ausbilder (Angestellten_Nr1, Angestellten_Nr2)
VALUES
    (1001, 1002),
    (1002, 1003);

-- Insert data into Organisator table
INSERT INTO Organisator (Angestellten_Nr)
VALUES
    (1004),
    (1005);

-- Insert data into Skriptentyp table
INSERT INTO Skriptentyp (Nummer, Autor, Kursname)
VALUES
    (1, 'Max Mustermann', 'Grundlagen der Programmierung'),
    (2, 'Anna Schmidt', 'Datenbanken'),
    (3, 'Thomas Müller', 'Webentwicklung'),
    (4, 'Sarah Wagner', 'Maschinelles Lernen'),
    (5, 'Michael Becker', 'Projektmanagement');

-- Insert data into Skript table
INSERT INTO Skript (Inventarnummer, Nummer)
VALUES
    (1001, 1),
    (1002, 1),
    (1003, 2),
    (1004, 3),
    (1005, 4),
    (1006, 5),
    (1007, 2),
    (1008, 3),
    (1009, 4),
    (1010, 5);

-- Insert data into Organisator_oder_Ausbilder_entleiht_Skript table
INSERT INTO Organisator_oder_Ausbilder_entleiht_Skript (Angestellten_Nr, Kennzeichnung, Inventar_Nr)
VALUES
    (NULL, 'AUSB-001', 1001),
    (NULL, 'AUSB-002', 1003),
    (1004, NULL, 1005),
    (1005, NULL, 1007),
    (NULL, 'AUSB-003', 1009);

-- Insert data into Seminar table
INSERT INTO Seminar (Datum, Uhrzeit, Platz, Ort, Straße, Haus_Nr, Kursname)
VALUES
    ('2023-10-15', '09:00:00', 20, 'Berlin', 'Hauptstraße', '12', 'Grundlagen der Programmierung'),
    ('2023-10-16', '13:00:00', 15, 'München', 'Bahnhofstraße', '5', 'Datenbanken'),
    ('2023-10-17', '10:30:00', 25, 'Köln', 'Domplatz', '1', 'Webentwicklung'),
    ('2023-10-18', '14:00:00', 10, 'Hamburg', 'Jungfernstieg', '25', 'Maschinelles Lernen'),
    ('2023-10-19', '11:00:00', 30, 'Stuttgart', 'Königstraße', '10', 'Projektmanagement');

-- Insert data into Teilnehmer_reserviert_Seminar table
INSERT INTO Teilnehmer_reserviert_Seminar (Reservierungs_Nr, Kunden_Nr, Datum, Uhrzeit)
VALUES
    (1, 2001, '2023-10-15', '09:00:00'),
    (2, 2002, '2023-10-16', '13:00:00'),
    (3, 2003, '2023-10-17', '10:30:00'),
    (4, 2004, '2023-10-18', '14:00:00'),
    (5, 2005, '2023-10-19', '11:00:00');

-- Insert data into Ausbilder_hat_Seminar table
INSERT INTO Ausbilder_hat_Seminar (Datum, Uhrzeit, Kennzeichnung)
VALUES
    ('2023-10-15', '09:00:00', 'AUSB-001'),
    ('2023-10-16', '13:00:00', 'AUSB-002'),
    ('2023-10-17', '10:30:00', 'AUSB-003'),
    ('2023-10-18', '14:00:00', 'AUSB-001'),
    ('2023-10-19', '11:00:00', 'AUSB-002');

-- Insert data into Ausbilder_hat_Kurs table
INSERT INTO ausbilder_hat_kurs (Kursname, Datum, Uhrzeit, Sprache)
VALUES ('Grundlagen der Programmierung', '2023-10-15', '09:00:00', 'Deutsch'),
       ('Datenbanken',                   '2023-10-16', '13:00:00', 'Englisch'),
       ('Webentwicklung',                '2023-10-17', '10:30:00', 'Deutsch'),
       ('Maschinelles Lernen',           '2023-10-18', '14:00:00', 'Englisch'),
       ('Projektmanagement',             '2023-10-19', '11:00:00', 'Deutsch');
