# Schnellstart-Anleitung

## Installation

1. Lade das Projekt herunter oder klone es:
   ```bash
   git clone https://github.com/leo-gall/goodnotes-to-something.git
   ```

2. Öffne `GoodnotesConverter.xcodeproj` in Xcode

3. Wähle dein Zielgerät (iPhone oder Simulator)

4. Drücke den Play-Button (▶) oder `Cmd + R`

## Erste Schritte

### 1. Datei auswählen
- Öffne die App
- Tippe auf "Select GoodNotes File"
- Wähle eine `.goodnotes` Datei aus deinen Dokumenten

### 2. Konvertieren
- Tippe auf "Convert"
- Warte bis die Konvertierung abgeschlossen ist
- Der Erfolgsbildschirm wird automatisch angezeigt

### 3. Exportieren
Wähle eine der drei Optionen:

**PDF Export:**
- Beste Qualität für Drucken
- Behält Bilder und Layout
- Kompatibel mit allen PDF-Viewern

**Markdown Export:**
- Perfekt für Text-Editoren
- Durchsuchbar und bearbeitbar
- Ideal für Notizen-Apps wie Obsidian, Notion

**Beide Formate:**
- Exportiert PDF und Markdown gleichzeitig
- Nutze das iOS Share Sheet zum Speichern/Teilen

## Tipps & Tricks

### Dateien finden
Die exportierten Dateien können gespeichert werden in:
- iCloud Drive
- Dateien App
- Andere Apps (teilen via Share Sheet)

### Beste Ergebnisse
- Verwende hochwertige GoodNotes-Dateien
- Kleinere Dateien konvertieren schneller
- Gute Internetverbindung nicht erforderlich (alles lokal)

### Probleme?
- Überprüfe ob die Datei wirklich eine GoodNotes-Datei ist
- Versuche die App neu zu starten
- Prüfe ob genügend Speicherplatz vorhanden ist

## Häufige Fragen (FAQ)

**Q: Welche Dateiformate werden unterstützt?**
A: Primär `.goodnotes` Dateien. Bilder (PNG, JPG) als Fallback.

**Q: Werden meine Dateien in die Cloud hochgeladen?**
A: Nein! Alle Konvertierungen passieren lokal auf deinem Gerät.

**Q: Kann ich mehrere Dateien gleichzeitig konvertieren?**
A: Aktuell nicht, aber das ist für zukünftige Versionen geplant.

**Q: Funktioniert die App offline?**
A: Ja! Keine Internetverbindung erforderlich.

**Q: Werden Handschrift-Notizen in Text konvertiert?**
A: Handschrift wird als Bild in PDF gespeichert. OCR ist nicht implementiert.

**Q: Kann ich das Markdown anpassen?**
A: Das Markdown folgt einem Standardformat. Anpassungen können manuell nach dem Export gemacht werden.

**Q: Wie groß dürfen die Dateien sein?**
A: Das hängt vom verfügbaren RAM deines Geräts ab. Sehr große Dateien können länger dauern.

## Support

Bei Problemen oder Fragen:
1. Prüfe die [README.md](README.md)
2. Schaue in [DEVELOPER.md](DEVELOPER.md) für technische Details
3. Erstelle ein Issue auf GitHub

## Weitere Ressourcen

- [GoodNotes Website](https://www.goodnotes.com)
- [SwiftUI Documentation](https://developer.apple.com/xcode/swiftui/)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
