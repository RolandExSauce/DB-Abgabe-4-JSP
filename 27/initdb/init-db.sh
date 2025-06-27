#!/usr/bin/env bash
# File: initdb/01_schema.sh
# Purpose: Create full training-center schema on first container start
set -e
echo "📥  Creating training-center schema in $POSTGRES_DB …"

psql -v ON_ERROR_STOP=1 \
     --username "$POSTGRES_USER" \
     --dbname   "$POSTGRES_DB" <<'SQL'
------------------------------------------------------------
--  PERSONEN & BASISDATEN
------------------------------------------------------------
CREATE TABLE Person (
    Zahl          INT,
    Geburtsdatum  DATE,
    Vorname       VARCHAR(100),
    Nachname      VARCHAR(100),
    PLZ           VARCHAR(10),
    Ort           VARCHAR(100),
    Straße        VARCHAR(100),
    Hausnummer    VARCHAR(10),
    PRIMARY KEY (Zahl, Geburtsdatum)
);

CREATE TABLE Bank (
    Bankleitzahl  VARCHAR(20) PRIMARY KEY,
    Name          VARCHAR(100)
);

CREATE TABLE Kurs (
    Kursname             VARCHAR(100) PRIMARY KEY,
    Anzahl_Organisatoren INT,
    Vorbereitungszeit    INT
);

------------------------------------------------------------
--  PERSON → KONTAKT
------------------------------------------------------------
CREATE TABLE Telefonnummer (
    Zahl          INT,
    Geburtsdatum  DATE,
    Nummer        VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (Zahl, Geburtsdatum)
        REFERENCES Person (Zahl, Geburtsdatum)
);

------------------------------------------------------------
--  ANGESTELLTE & KONTEN
------------------------------------------------------------
CREATE TABLE Angestellter (
    Zahl             INT,
    Geburtsdatum     DATE,
    Angestellten_Nr  INT PRIMARY KEY,
    FOREIGN KEY (Zahl, Geburtsdatum)
        REFERENCES Person (Zahl, Geburtsdatum)
);

CREATE TABLE Gehaltskonto (
    Angestellten_Nr  INT,
    Bankleitzahl     VARCHAR(20),
    Konto_Nr         VARCHAR(30),
    Kontostand       DECIMAL(10,2),
    PRIMARY KEY (Konto_Nr, Bankleitzahl),
    FOREIGN KEY (Angestellten_Nr)
        REFERENCES Angestellter (Angestellten_Nr),
    FOREIGN KEY (Bankleitzahl)
        REFERENCES Bank (Bankleitzahl)
);

------------------------------------------------------------
--  AUSBILDER, ORGANISATOREN & BEZIEHUNGEN
------------------------------------------------------------
CREATE TABLE Ausbilder (
    Angestellten_Nr  INT,
    Einstellungsdatum DATE,
    Kennzeichnung    VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (Angestellten_Nr)
        REFERENCES Angestellter (Angestellten_Nr)
);

CREATE TABLE Organisator (
    Angestellten_Nr  INT PRIMARY KEY,
    FOREIGN KEY (Angestellten_Nr)
        REFERENCES Angestellter (Angestellten_Nr)
);

CREATE TABLE Ausbilder_hasst_Ausbilder (
    Angestellten_Nr1 INT,
    Angestellten_Nr2 INT,
    PRIMARY KEY (Angestellten_Nr1, Angestellten_Nr2),
    FOREIGN KEY (Angestellten_Nr1)
        REFERENCES Angestellter (Angestellten_Nr),
    FOREIGN KEY (Angestellten_Nr2)
        REFERENCES Angestellter (Angestellten_Nr)
);

------------------------------------------------------------
--  TEILNEHMER
------------------------------------------------------------
CREATE TABLE Teilnehmer (
    Zahl          INT,
    Geburtsdatum  DATE,
    Kunden_Nr     INT PRIMARY KEY,
    Kennzeichnung VARCHAR(50),
    FOREIGN KEY (Zahl, Geburtsdatum)
        REFERENCES Person (Zahl, Geburtsdatum),
    FOREIGN KEY (Kennzeichnung)
        REFERENCES Ausbilder (Kennzeichnung)
);

------------------------------------------------------------
--  SKRIPT-INVENTAR
------------------------------------------------------------
CREATE TABLE Skriptentyp (
    Nummer     INT PRIMARY KEY,
    Autor      VARCHAR(100),
    Kursname   VARCHAR(100),
    FOREIGN KEY (Kursname)
        REFERENCES Kurs (Kursname)
);

CREATE TABLE Skript (
    Inventarnummer INT PRIMARY KEY,
    Nummer         INT,
    FOREIGN KEY (Nummer)
        REFERENCES Skriptentyp (Nummer)
);

CREATE TABLE Organisator_oder_Ausbilder_entleiht_Skript (
    Angestellten_Nr INT,
    Kennzeichnung   VARCHAR(50),
    Inventar_Nr     INT PRIMARY KEY,
    FOREIGN KEY (Angestellten_Nr)
        REFERENCES Organisator (Angestellten_Nr),
    FOREIGN KEY (Kennzeichnung)
        REFERENCES Ausbilder (Kennzeichnung),
    FOREIGN KEY (Inventar_Nr)
        REFERENCES Skript (Inventarnummer)
);

------------------------------------------------------------
--  SEMINARE & BUCHUNGEN
------------------------------------------------------------
CREATE TABLE Seminar (
    Datum     DATE,
    Uhrzeit   TIME,
    Platz     INT,
    Ort       VARCHAR(100),
    Straße    VARCHAR(100),
    Haus_Nr   VARCHAR(10),
    Kursname  VARCHAR(100),
    PRIMARY KEY (Datum, Uhrzeit),
    FOREIGN KEY (Kursname)
        REFERENCES Kurs (Kursname)
);

CREATE TABLE Teilnehmer_reserviert_Seminar (
    Reservierungs_Nr INT PRIMARY KEY,
    Kunden_Nr        INT,
    Datum            DATE,
    Uhrzeit          TIME,
    FOREIGN KEY (Kunden_Nr)
        REFERENCES Teilnehmer (Kunden_Nr),
    FOREIGN KEY (Datum, Uhrzeit)
        REFERENCES Seminar (Datum, Uhrzeit)
);

CREATE TABLE Ausbilder_hat_Seminar (
    Datum         DATE,
    Uhrzeit       TIME,
    Kennzeichnung VARCHAR(50),
    PRIMARY KEY (Datum, Uhrzeit, Kennzeichnung),
    FOREIGN KEY (Kennzeichnung)
        REFERENCES Ausbilder (Kennzeichnung),
    FOREIGN KEY (Datum, Uhrzeit)
        REFERENCES Seminar (Datum, Uhrzeit)
);

CREATE TABLE Ausbilder_hat_Kurs (
    Kursname VARCHAR(100),
    Datum    DATE,
    Uhrzeit  TIME,
    Sprache  VARCHAR(50),
    PRIMARY KEY (Kursname, Datum, Uhrzeit),
    FOREIGN KEY (Kursname)
        REFERENCES Kurs (Kursname)
    -- Falls nötig, hier zusätzlich:
    -- , FOREIGN KEY (Kennzeichnung) REFERENCES Ausbilder(Kennzeichnung)
);

------------------------------------------------------------
--  QUICK CHECK
------------------------------------------------------------
\echo '📄  Tabellenübersicht nach Erstellung:'
\dt

echo "✅  Schema successfully created"