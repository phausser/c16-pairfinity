# Endlos-Memory — TODO

Jede Stufe läuft in VICE, bevor die nächste beginnt. Regeln und Speicher stehen in `SPEC.md`.

- [x] Stub bei `$1001`, schwarzer Schirm, ein Apfel aus dem Zeichensatz bei `$3000`: 3×3, rote Fläche, schwarze Silhouette mittig. `make` und `make run` starten `xplus4 -model c16`.
- [x] Raster 4×6 mit verdeckten Karten und Zeichenlücke. Die angewählte verdeckte Karte ist weiss. Joystick 1 und Pfeiltasten, ein Schritt pro Flanke, nächste liegende Karte in der Richtung.
- [x] Zwei Karten aufdecken. Paar bleibt etwa 30 Frames offen und leert dann beide Plätze. Ein Fehlversuch bleibt offen, bis eine Cursortaste kommt, und dreht sich dann zu. Dieselbe Karte und leere Plätze lassen sich nicht wählen.
- [x] Spalten packen sich animiert nach unten. Danach fällt eine neue Karte von über dem Raster in eine zufällige Spalte mit Platz. Motiv ist das einer zufälligen liegenden Karte. Leeres Feld: Motiv 1–8.
- [x] Start mit 4×3: acht Früchte mindestens einmal, vier weitere Kopien, gemischt, untenbündig. Flächenfarben aus der Tabelle in `SPEC.md`, Frucht schwarz. `PAARE` und drei Ziffern oben rechts. `START` und `GAME OVER` blinken in der Bildschirmmitte. Neustart, wenn nach dem Zug kein Platz frei ist.
- [x] TED-Ton: hoch bei einem Paar, tief bei einem Fehlversuch, Tick je Fallschritt. Zeiten so, dass Aufdecken, Packen und Fallen lesbar sind.
