# Das `firstrun` Skript

Das `firstrun`-Skript selbst ist essentiell nur ein Wrapper für die Skripte in `./scripts`

Diese werden der Reihenfolge nach ausgeführt, aufsteigend geordnet nach der Zahl am Anfang des Skriptnamens.

Damit das Skript die Sub-Skripte nicht bei jedem Start ausführt wird nach dem erfolgreichen Abschließen eines Sub-Skripts eine Sperrdatei erstellt, die dieses Skript deaktiviert.