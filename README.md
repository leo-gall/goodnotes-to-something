# GoodNotes Converter

Eine iOS Swift App zum Konvertieren von GoodNotes-Dateien in PDF und Markdown.

## Funktionen

- 📱 Native iOS App mit SwiftUI
- 📄 Konvertierung von GoodNotes-Dateien zu PDF
- 📝 Konvertierung von GoodNotes-Dateien zu Markdown
- 🎨 Moderne, benutzerfreundliche Oberfläche
- 📤 Einfacher Export über iOS Share Sheet
- 🔄 Unterstützung für mehrere Seiten
- 📊 Metadaten-Extraktion

## Anforderungen

- iOS 16.0 oder höher
- Xcode 15.0 oder höher
- Swift 5.9 oder höher

## Installation

1. Klone das Repository:
```bash
git clone https://github.com/leo-gall/goodnotes-to-something.git
cd goodnotes-to-something
```

2. Öffne das Projekt in Xcode:
```bash
open GoodnotesConverter.xcodeproj
```

3. Wähle dein Zielgerät oder einen Simulator aus

4. Drücke `Cmd + R` um die App zu bauen und zu starten

## Verwendung

1. **Datei auswählen**: Tippe auf "Select GoodNotes File" um eine GoodNotes-Datei auszuwählen
2. **Konvertieren**: Tippe auf "Convert" um die Konvertierung zu starten
3. **Exportieren**: Wähle zwischen:
   - Export als PDF
   - Export als Markdown
   - Beide Formate exportieren

### Unterstützte Dateiformate

- `.goodnotes` - GoodNotes-Dateien
- Bilder (PNG, JPG, JPEG) als Fallback

## Projektstruktur

```
GoodnotesConverter/
├── GoodnotesConverter.xcodeproj/    # Xcode Projektdatei
└── GoodnotesConverter/              # Hauptverzeichnis der App
    ├── GoodnotesConverterApp.swift  # App Entry Point
    ├── ContentView.swift            # Haupt-UI
    ├── FilePickerView.swift         # Dateiauswahl
    ├── ExportView.swift             # Export-Funktionalität
    ├── GoodnotesParser.swift        # GoodNotes-Datei Parser
    ├── PDFConverter.swift           # PDF-Konverter
    ├── MarkdownConverter.swift      # Markdown-Konverter
    ├── Assets.xcassets/             # App-Assets
    └── Info.plist                   # App-Konfiguration
```

## Architektur

### GoodnotesParser
Verantwortlich für das Parsen von GoodNotes-Dateien und Extraktion von:
- Seiteninhalten
- Bildern
- Text
- Metadaten

### PDFConverter
Konvertiert geparste Daten in PDF-Format mit:
- Bild-Rendering
- Text-Layout
- Seitennummerierung
- Metadaten-Einbettung

### MarkdownConverter
Erstellt Markdown-Dokumente mit:
- Strukturierten Headern
- Seitenorganisation
- Metadaten-Header
- Annotations-Unterstützung

## Entwicklung

### Code-Struktur

Die App folgt dem MVVM-Pattern mit SwiftUI:
- **Views**: SwiftUI Views für die Benutzeroberfläche
- **Models**: Datenstrukturen (GoodnotesData, PageData, etc.)
- **Services**: Konverter und Parser

### Testen

Um die App zu testen:
1. Starte die App im Simulator oder auf einem Gerät
2. Wähle eine Test-Datei aus
3. Führe die Konvertierung durch
4. Überprüfe die exportierten Dateien

## Einschränkungen

- GoodNotes-Dateien verwenden ein proprietäres Format
- Diese Implementierung bietet grundlegende Konvertierungsfunktionalität
- Für vollständige GoodNotes-Kompatibilität wären weitere Parsing-Funktionen erforderlich

## Zukünftige Verbesserungen

- [ ] Erweiterte GoodNotes-Dateiformatunterstützung
- [ ] OCR für handschriftliche Notizen
- [ ] Batch-Konvertierung mehrerer Dateien
- [ ] Cloud-Storage-Integration
- [ ] Anpassbare Export-Optionen
- [ ] Dark Mode Optimierung

## Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert.

## Autor

Leo Gall

## Beiträge

Beiträge sind willkommen! Bitte erstelle einen Pull Request oder öffne ein Issue für Vorschläge.