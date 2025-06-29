-- Insert sample persons
INSERT INTO Person (Zahl, Geburtsdatum, Vorname, Nachname, PLZ, Ort, Straße, Hausnummer)
VALUES
    (1, '1990-05-15', 'Max', 'Mustermann', '1010', 'Wien', 'Graben', '12'),
    (2, '1985-08-22', 'Anna', 'Schmidt', '8010', 'Graz', 'Herrengasse', '5'),
    (3, '1978-11-03', 'Thomas', 'Müller', '5020', 'Salzburg', 'Getreidegasse', '1'),
    (4, '1992-03-10', 'Lisa', 'Weber', '4020', 'Linz', 'Landstraße', '8'),
    (5, '1988-12-25', 'Michael', 'Fischer', '6020', 'Innsbruck', 'Maria-Theresien-Straße', '15'),
    (6, '1995-07-14', 'Sarah', 'Wagner', '6900', 'Bregenz', 'Kornmarktstraße', '22'),
    (7, '1983-09-30', 'David', 'Becker', '7000', 'Eisenstadt', 'Hauptstraße', '3'),
    (8, '1991-01-20', 'Julia', 'Hoffmann', '3500', 'Krems', 'Landstraße', '7');

-- Insert banks
INSERT INTO Bank (Bankleitzahl, Name)
VALUES
    ('12000', 'Erste Bank'),
    ('20111', 'Bank Austria'),
    ('14000', 'Raiffeisen Bank International'),
    ('12000', 'Sparkasse'),
    ('14000', 'Volksbank');

-- Insert courses
INSERT INTO Kurs (Kursname, Anzahl_Organisatoren, Vorbereitungszeit)
VALUES
    ('Datenbanken', 2, 180),
    ('Programmierung', 3, 240),
    ('Webentwicklung', 1, 120),
    ('Netzwerktechnik', 2, 150),
    ('Betriebssysteme', 1, 200);

-- Insert phone numbers
INSERT INTO Telefonnummer (Zahl, Geburtsdatum, Nummer)
VALUES
    (1, '1990-05-15', '+43 1 12345678'),
    (2, '1985-08-22', '+43 316 87654321'),
    (3, '1978-11-03', '+43 662 11223344'),
    (4, '1992-03-10', '+43 732 55667788'),
    (5, '1988-12-25', '+43 512 99887766');

-- Insert employees
INSERT INTO Angestellter (Zahl, Geburtsdatum, Angestellten_Nr)
VALUES
    (1, '1990-05-15', 1001),
    (2, '1985-08-22', 1002),
    (3, '1978-11-03', 1003),
    (4, '1992-03-10', 1004),
    (5, '1988-12-25', 1005);

-- Insert salary accounts
INSERT INTO Gehaltskonto (Angestellten_Nr, Bankleitzahl, Konto_Nr, Kontostand)
VALUES
    (1001, '12000', 'AT123456789012345678', 3500.00),
    (1002, '20111', 'AT098765432109876543', 4200.00),
    (1003, '14000', 'AT112233445566778899', 3800.00),
    (1004, '12000', 'AT223344556677889900', 3100.00),
    (1005, '14000', 'AT334455667788990011', 4500.00);

-- Insert trainers
INSERT INTO Ausbilder (Angestellten_Nr, Einstellungsdatum, Kennzeichnung)
VALUES
    (1001, '2020-01-15', 'TRAINER_001'),
    (1002, '2019-03-20', 'TRAINER_002'),
    (1003, '2018-07-10', 'TRAINER_003'),
    (1004, '2021-02-28', 'TRAINER_004'),
    (1005, '2017-11-05', 'TRAINER_005');

-- Insert participants
INSERT INTO Teilnehmer (Zahl, Geburtsdatum, Kunden_Nr, Kennzeichnung)
VALUES
    (6, '1995-07-14', 2001, 'TRAINER_001'),
    (7, '1983-09-30', 2002, 'TRAINER_002'),
    (8, '1991-01-20', 2003, 'TRAINER_003');

-- Insert trainer conflicts (some trainers don't like each other)
INSERT INTO Ausbilder_hasst_Ausbilder (Angestellten_Nr1, Angestellten_Nr2)
VALUES
    (1001, 1002),
    (1003, 1004);

-- Insert organizers
INSERT INTO Organisator (Angestellten_Nr)
VALUES
    (1001),
    (1003),
    (1005);

-- Insert script types
INSERT INTO Skriptentyp (Nummer, Autor, Kursname)
VALUES
    (1, 'Dr. Hans Mueller', 'Datenbanken'),
    (2, 'Prof. Maria Schmidt', 'Programmierung'),
    (3, 'Dipl. Ing. Klaus Weber', 'Webentwicklung'),
    (4, 'Dr. Petra Fischer', 'Netzwerktechnik'),
    (5, 'Prof. Wolfgang Wagner', 'Betriebssysteme');

-- Insert scripts (multiple copies of each type)
INSERT INTO Skript (Inventarnummer, Nummer)
VALUES
    (1001, 1),
    (1002, 1),
    (1003, 2),
    (1004, 2),
    (1005, 2),
    (1006, 3),
    (1007, 4),
    (1008, 4),
    (1009, 5),
    (1010, 5);

-- Insert script loans
INSERT INTO Organisator_oder_Ausbilder_entleiht_Skript (Angestellten_Nr, Kennzeichnung, Inventar_Nr)
VALUES
    (1001, NULL, 1001),
    (NULL, 'TRAINER_002', 1003),
    (1003, NULL, 1005),
    (NULL, 'TRAINER_004', 1007),
    (1005, NULL, 1009);

-- Insert seminars
INSERT INTO Seminar (Datum, Uhrzeit, Platz, Ort, Straße, Haus_Nr, Kursname)
VALUES
    ('2024-01-15', '09:00:00', 20, 'Wien', 'Graben', '1', 'Datenbanken'),
    ('2024-01-16', '14:00:00', 15, 'Graz', 'Herrengasse', '5', 'Programmierung'),
    ('2024-01-17', '10:00:00', 25, 'Salzburg', 'Getreidegasse', '10', 'Webentwicklung'),
    ('2024-01-18', '13:00:00', 18, 'Linz', 'Landstraße', '8', 'Netzwerktechnik'),
    ('2024-01-19', '11:00:00', 22, 'Innsbruck', 'Maria-Theresien-Straße', '15', 'Betriebssysteme');

-- Insert seminar reservations
INSERT INTO Teilnehmer_reserviert_Seminar (Reservierungs_Nr, Kunden_Nr, Datum, Uhrzeit)
VALUES
    (3001, 2001, '2024-01-15', '09:00:00'),
    (3002, 2002, '2024-01-16', '14:00:00'),
    (3003, 2003, '2024-01-17', '10:00:00'),
    (3004, 2001, '2024-01-18', '13:00:00'),
    (3005, 2002, '2024-01-19', '11:00:00');

-- Insert trainer-seminar assignments
INSERT INTO Ausbilder_hat_Seminar (Datum, Uhrzeit, Kennzeichnung)
VALUES
    ('2024-01-15', '09:00:00', 'TRAINER_001'),
    ('2024-01-16', '14:00:00', 'TRAINER_002'),
    ('2024-01-17', '10:00:00', 'TRAINER_003'),
    ('2024-01-18', '13:00:00', 'TRAINER_004'),
    ('2024-01-19', '11:00:00', 'TRAINER_005');

-- Insert trainer-course assignments (note: this table has the design issue mentioned in the TODO)
INSERT INTO Ausbilder_hat_Kurs (Kursname, Datum, Uhrzeit, Sprache)
VALUES
    ('Datenbanken', '2024-01-15', '09:00:00', 'Deutsch'),
    ('Programmierung', '2024-01-16', '14:00:00', 'Deutsch'),
    ('Webentwicklung', '2024-01-17', '10:00:00', 'Englisch'),
    ('Netzwerktechnik', '2024-01-18', '13:00:00', 'Deutsch'),
    ('Betriebssysteme', '2024-01-19', '11:00:00', 'Deutsch');

