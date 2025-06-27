CREATE TABLE Person (
    Zahl INT,
    Geburtsdatum DATE,
    Vorname VARCHAR(100),
    Nachname VARCHAR(100),
    PLZ VARCHAR(10),
    Ort VARCHAR(100),
    Straße VARCHAR(100),
    Hausnummer VARCHAR(10),
    PRIMARY KEY (Zahl, Geburtsdatum)
);

CREATE TABLE Bank (
    Bankleitzahl VARCHAR(20),
    Name VARCHAR(100),
    PRIMARY KEY (Bankleitzahl)
);

CREATE TABLE Kurs (
    Kursname VARCHAR(100),
    Anzahl_Organisatoren INT,
    Vorbereitungszeit INT,
    PRIMARY KEY (Kursname)
);

CREATE TABLE Telefonnummer (
    Zahl INT,
    Geburtsdatum DATE,
    Nummer VARCHAR(20),
    PRIMARY KEY (Nummer),
    FOREIGN KEY (Zahl, Geburtsdatum) REFERENCES Person(Zahl, Geburtsdatum)
);

CREATE TABLE Angestellter (
    Zahl INT,
    Geburtsdatum DATE,
    Angestellten_Nr INT,
    PRIMARY KEY (Angestellten_Nr),
    FOREIGN KEY (Zahl, Geburtsdatum) REFERENCES Person(Zahl, Geburtsdatum)
);

CREATE TABLE Gehaltskonto (
    Angestellten_Nr INT,
    Bankleitzahl VARCHAR(20),
    Konto_Nr VARCHAR(30),
    Kontostand DECIMAL(10, 2),
    PRIMARY KEY (Konto_Nr, Bankleitzahl),
    FOREIGN KEY (Angestellten_Nr) REFERENCES Angestellter(Angestellten_Nr),
    FOREIGN KEY (Bankleitzahl) REFERENCES Bank(Bankleitzahl)
);

CREATE TABLE Ausbilder (
    Angestellten_Nr INT,
    Einstellungsdatum DATE,
    Kennzeichnung VARCHAR(50),
    PRIMARY KEY (Kennzeichnung),
    FOREIGN KEY (Angestellten_Nr) REFERENCES Angestellter(Angestellten_Nr)
);

CREATE TABLE Teilnehmer (
    Zahl INT,
    Geburtsdatum DATE,
    Kunden_Nr INT,
    Kennzeichnung VARCHAR(50),
    PRIMARY KEY (Kunden_Nr),
    FOREIGN KEY (Zahl, Geburtsdatum) REFERENCES Person(Zahl, Geburtsdatum),
    FOREIGN KEY (Kennzeichnung) REFERENCES Ausbilder(Kennzeichnung)
);

CREATE TABLE Ausbilder_hasst_Ausbilder (
    Angestellten_Nr1 INT,
    Angestellten_Nr2 INT,
    PRIMARY KEY (Angestellten_Nr1, Angestellten_Nr2),
    FOREIGN KEY (Angestellten_Nr1) REFERENCES Angestellter(Angestellten_Nr),
    FOREIGN KEY (Angestellten_Nr2) REFERENCES Angestellter(Angestellten_Nr)
);

CREATE TABLE Organisator (
    Angestellten_Nr INT,
    PRIMARY KEY (Angestellten_Nr),
    FOREIGN KEY (Angestellten_Nr) REFERENCES Angestellter(Angestellten_Nr)
);

CREATE TABLE Skriptentyp (
    Nummer INT,
    Autor VARCHAR(100),
    Kursname VARCHAR(100),
    PRIMARY KEY (Nummer),
    FOREIGN KEY (Kursname) REFERENCES Kurs(Kursname)
);

CREATE TABLE Skript (
    Inventarnummer INT,
    Nummer INT,
    PRIMARY KEY (Inventarnummer),
    FOREIGN KEY (Nummer) REFERENCES Skriptentyp(Nummer)
);

CREATE TABLE Organisator_oder_Ausbilder_entleiht_Skript (
    Angestellten_Nr INT,
    Kennzeichnung VARCHAR(50),
    Inventar_Nr INT,
    PRIMARY KEY (Inventar_Nr),
    FOREIGN KEY (Angestellten_Nr) REFERENCES Organisator(Angestellten_Nr),
    FOREIGN KEY (Kennzeichnung) REFERENCES Ausbilder(Kennzeichnung),
    FOREIGN KEY (Inventar_Nr) REFERENCES Skript(Inventarnummer)
);

CREATE TABLE Seminar (
    Datum DATE,
    Uhrzeit TIME,
    Platz INT,
    Ort VARCHAR(100),
    Straße VARCHAR(100),
    Haus_Nr VARCHAR(10),
    Kursname VARCHAR(100),
    PRIMARY KEY (Datum, Uhrzeit),
    FOREIGN KEY (Kursname) REFERENCES Kurs(Kursname)
);

CREATE TABLE Teilnehmer_reserviert_Seminar (
    Reservierungs_Nr INT,
    Kunden_Nr INT,
    Datum DATE,
    Uhrzeit TIME,
    PRIMARY KEY (Reservierungs_Nr),
    FOREIGN KEY (Kunden_Nr) REFERENCES Teilnehmer(Kunden_Nr),
    FOREIGN KEY (Datum, Uhrzeit) REFERENCES Seminar(Datum, Uhrzeit)
);

CREATE TABLE Ausbilder_hat_Seminar (
    Datum DATE,
    Uhrzeit TIME,
    Kennzeichnung VARCHAR(50),
    PRIMARY KEY (Datum, Uhrzeit, Kennzeichnung),
    FOREIGN KEY (Kennzeichnung) REFERENCES Ausbilder(Kennzeichnung),
    FOREIGN KEY (Datum, Uhrzeit) REFERENCES Seminar(Datum, Uhrzeit)
);

CREATE TABLE Ausbilder_hat_Kurs (
    Kursname VARCHAR(100),
    Datum DATE,
    Uhrzeit TIME,
    Sprache VARCHAR(50),
    PRIMARY KEY (Kursname, Datum, Uhrzeit),
    FOREIGN KEY (Kursname) REFERENCES Kurs(Kursname)
    -- Hinweis: Keine direkte Referenz auf Ausbilder vorhanden – möglicherweise ein Fehler im Modell
);

