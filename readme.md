# 🚧 LayerSentinel – *Under Construction* 🏗️

Willkommen zu **LayerSentinel** by *Pingel AI Solutions*! 👋  
Dieses Projekt dient zur Überwachung und Steuerung eines **BambuLab 3D-Druckers** über eine API.  
Die folgende Anleitung hilft dir bei der Einrichtung und Nutzung des Programms.  

> ⚠️ **Hinweis:** Das Projekt befindet sich noch in der Entwicklung – Funktionen und Abläufe können sich noch ändern!

---

## 🐍 Einrichtung der virtuellen Umgebung

Erstelle zuerst eine neue virtuelle Umgebung, um die Abhängigkeiten getrennt vom System zu installieren:

```bash
python -m venv env
```

---

## ⚙️ Aktivierung der Umgebung

Aktiviere anschließend die Umgebung:

```bash
env\Scripts\activate
```

Wenn im Terminal `(env)` angezeigt wird, bist du bereit! ✅

---

## 📦 Abhängigkeiten installieren

Zunächst sollte `pip` aktualisiert werden:

```bash
python.exe -m pip install --upgrade pip
```

Danach installiere alle benötigten Bibliotheken aus der `requirements.txt`:

```bash
pip install -r requirements.txt
```

---

## 🔐 Konfiguration vorbereiten

Vor dem Start muss die Datei **`.env`** mit den Zugangsdaten deines BambuLab-Druckers befüllt werden.  
Erstelle oder öffne die Datei im Projektverzeichnis und trage Folgendes ein:

```env
DEBUG = True
IP = 192.XXX.XXX.XXX
SERIAL = XXXXXXXXXXXXXXXX
ACCESS_CODE = XXXXXXXX
```

> 🧠 **Tipp:** Die Daten findest du in deinem Drucker-Menü oder in deinem BambuLab-Account.

---

## ▶️ Programm starten

Nachdem alles eingerichtet ist, starte das Programm mit:

```bash
python main.py
```

---

## 🧠 Was macht die `main.py`?

Die `main.py` ist das **Herzstück des Projekts**.  
Sie startet den LayerSentinel-Service und übernimmt folgende Aufgaben:

1. **🔧 Initialisierung & Logging**  
   - Konfiguriert das Logging-System für strukturierte Ausgaben.  
   - Startet den LayerSentinel-Dienst.

2. **🌐 Verbindung zum Drucker herstellen**  
   - Liest die Zugangsdaten (`IP`, `SERIAL`, `ACCESS_CODE`) aus der `.env` oder über die Hilfsfunktionen.  
   - Baut eine sichere Verbindung zum BambuLab 3D-Drucker auf.  

3. **🖨️ Druckerstatus prüfen**  
   - Ermittelt den aktuellen Druckerstatus (z. B. *PRINTING*, *IDLE*, *PAUSED*).  
   - Gibt Statusinformationen wie Layer-Fortschritt, Temperaturen und geschätzte Restzeit aus.  

4. **📸 Kameraüberwachung**  
   - Ruft regelmäßig ein Kamerabild ab und speichert es als `example.png`.  
   - So kannst du den Druckprozess visuell überwachen.

5. **💡 Lichtsteuerung**  
   - Prüft, ob das Druckerlicht eingeschaltet ist – und schaltet es bei Bedarf automatisch ein.  

6. **🧮 Status-Updates**  
   - Während des Drucks werden kontinuierlich Layer-Fortschritt, Temperaturen und geschätzte Endzeit ausgegeben.  

7. **🔌 Sicheres Beenden**  
   - Nach Abschluss oder bei Fehlern trennt das Programm sauber die Verbindung zum Drucker.  

---

## 🪲 Debug-Modus

Wenn `DEBUG = True` in der `.env` gesetzt ist, werden zusätzliche Details im Terminal ausgegeben.  
Vorsicht: Hier können vertrauliche Informationen (z. B. Access Codes) sichtbar sein! ⚠️

---

## 🎉 Fertig!

Wenn du alles richtig gemacht hast, sollte im Terminal erscheinen:

```
🟢 Starte *LayerSentinel* by Pingel AI Solutions...
🔌 Verbindung zum BambuLab 3D-Drucker herstellen...
🖨️ Druckerstatus: PRINTING
📸 Kameraüberwachung gestartet...
```

Du hast LayerSentinel erfolgreich eingerichtet und gestartet! 🚀  
Viel Spaß beim 3D-Druck-Monitoring 🧠🖨️💡

