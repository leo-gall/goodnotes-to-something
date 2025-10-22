# GoodNotes Converter - Entwicklerdokumentation

## Übersicht

Diese iOS-App konvertiert GoodNotes-Dateien in PDF und Markdown-Format. Die App ist in Swift mit SwiftUI entwickelt und unterstützt iOS 16.0+.

## Architektur

### Komponenten

#### 1. GoodnotesConverterApp.swift
Entry Point der App. Definiert die App-Struktur mit SwiftUI.

```swift
@main
struct GoodnotesConverterApp: App
```

#### 2. ContentView.swift
Haupt-UI der App mit folgenden Features:
- Dateiauswahl Button
- Konvertierungs-Button
- Status-Anzeigen
- Fehlerbehandlung

States:
- `selectedFileURL`: URL der ausgewählten Datei
- `showFilePicker`: File Picker anzeigen
- `showExportView`: Export View anzeigen
- `isConverting`: Konvertierung läuft
- `errorMessage`: Fehlermeldung

#### 3. FilePickerView.swift
UIKit Document Picker in SwiftUI integriert.
- Unterstützt `.goodnotes` Dateien
- Nutzt `UIViewControllerRepresentable`

#### 4. ExportView.swift
Export-Funktionalität mit:
- PDF Export
- Markdown Export
- Beide Formate gleichzeitig
- iOS Share Sheet Integration

#### 5. GoodnotesParser.swift
Parst GoodNotes-Dateien:
- Liest Dateiinhalte
- Extrahiert Bilder
- Extrahiert Text
- Sammelt Metadaten

Datenstrukturen:
```swift
struct GoodnotesData {
    var pages: [PageData]
    var metadata: [String: String]
}

struct PageData {
    var pageNumber: Int
    var image: UIImage?
    var text: String
    var annotations: [Annotation]
}
```

#### 6. PDFConverter.swift
Konvertiert zu PDF:
- Nutzt `UIGraphicsPDFRenderer`
- Rendert Bilder
- Formatiert Text
- Fügt Seitenzahlen hinzu

#### 7. MarkdownConverter.swift
Konvertiert zu Markdown:
- Strukturiertes Format
- Metadaten-Header
- Seitenweise Organisation
- Annotations-Support

## Datenfluss

```
Benutzer wählt Datei
    ↓
FilePickerView
    ↓
ContentView (selectedFileURL gesetzt)
    ↓
Benutzer klickt "Convert"
    ↓
GoodnotesParser.parse()
    ↓
GoodnotesData erstellt
    ↓
PDFConverter.convert() + MarkdownConverter.convert()
    ↓
ExportView mit PDF & Markdown Daten
    ↓
Benutzer exportiert Dateien
```

## Threading

- UI-Updates: Main Thread
- Datei-Parsing: Background Thread (`DispatchQueue.global`)
- Konvertierung: Background Thread
- Export: Main Thread (iOS APIs)

## Fehlerbehandlung

Alle Konverter werfen typisierte Errors:

```swift
enum ParserError: Error {
    case invalidFileFormat
    case unableToReadFile
    case noDataFound
    case unsupportedFormat
}

enum ConversionError: Error {
    case noPages
    case pdfCreationFailed
}
```

## Testing

### Manuelles Testing
1. App in Xcode öffnen
2. Auf iOS Simulator oder Gerät ausführen
3. Test-Datei auswählen
4. Konvertierung durchführen
5. Exportierte Dateien überprüfen

### Unit Tests (zukünftig)
- Parser Tests
- Konverter Tests
- UI Tests

## Performance-Überlegungen

1. **Große Dateien**: Asynchrone Verarbeitung verhindert UI-Blocking
2. **Speicher**: Temporäre Dateien werden nach Verarbeitung gelöscht
3. **Threading**: Background-Threads für I/O-intensive Operationen

## Sicherheit

1. **Dateizugriff**: Nutzt iOS Sandboxing
2. **Temporäre Dateien**: Automatische Bereinigung
3. **Berechtigungen**: Document Picker erfordert keine zusätzlichen Permissions

## Erweiterungsmöglichkeiten

### Kurzfristig
- Fortschrittsbalken für lange Konvertierungen
- Mehrere Dateien gleichzeitig
- Einstellungen für Export-Format

### Mittelfristig
- OCR für handgeschriebene Notizen
- Cloud-Storage Integration
- Batch-Verarbeitung

### Langfristig
- watchOS Support
- macOS Catalyst Version
- Widget Support

## Bekannte Einschränkungen

1. GoodNotes-Format ist proprietär
2. Vollständige Parsing-Funktionalität erfordert Reverse Engineering
3. Handschrift wird als Bild behandelt (kein OCR)
4. Komplexe Annotations können verloren gehen

## Build-Konfiguration

- Deployment Target: iOS 16.0
- Swift Version: 5.0+
- Xcode Version: 15.0+
- Code Signing: Automatisch (Development)

## App-Berechtigungen

In Info.plist konfiguriert:
- `UIFileSharingEnabled`: Dateifreigabe
- `LSSupportsOpeningDocumentsInPlace`: Dokumente öffnen
- `UTImportedTypeDeclarations`: GoodNotes Dateityp

## Troubleshooting

### App startet nicht
- Überprüfe Deployment Target
- Bereinige Build Folder (Cmd+Shift+K)
- Simulator neu starten

### Konvertierung schlägt fehl
- Prüfe Dateiformat
- Prüfe Dateigröße
- Prüfe Logs in Console.app

### Export funktioniert nicht
- Überprüfe Speicherplatz
- Prüfe App-Berechtigungen
- Teste mit kleinerer Datei
