# TODO Pakete für jeden Team Mitglied werden hier abgebildet


Berkant: /initdb/init.sql

task1: Analyse statement:
CREATE TABLE Ausbilder_hat_Kurs (
Kursname VARCHAR(100),
Datum DATE,
Uhrzeit TIME,
Sprache VARCHAR(50),
PRIMARY KEY (Kursname, Datum, Uhrzeit),
FOREIGN KEY (Kursname) REFERENCES Kurs(Kursname)
-- Hinweis: Keine direkte Referenz auf Ausbilder vorhanden – möglicherweise ein Fehler im Modell
);

Dieser Kommentar: "-- Hinweis: Keine direkte Referenz auf Ausbilder vorhanden – möglicherweise ein Fehler im Modell"
-> Welche Auswirkung hat es auf das Gesamte Schema ? 

task2: test.sql

-> abfragen testen 



