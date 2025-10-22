# App Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    GoodNotes Converter App                      │
│                      (iOS 16.0+, SwiftUI)                       │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                         User Interface                          │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ ContentView  │──│FilePickerView│  │  ExportView  │         │
│  │              │  │              │  │              │         │
│  │ - Hauptansicht│ │ - Dateiauswahl│ │ - PDF Export │         │
│  │ - Konvertieren│ │ - iOS Picker │  │ - MD Export  │         │
│  │ - Status     │  │              │  │ - Share Sheet│         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Business Logic Layer                       │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │GoodnotesParser│ │ PDFConverter │  │MarkdownConv. │         │
│  │              │  │              │  │              │         │
│  │ - File Read  │  │ - PDF Create │  │ - MD Format  │         │
│  │ - Extract    │  │ - Render     │  │ - Text Struct│         │
│  │ - Parse      │  │ - Metadata   │  │ - Metadata   │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Data Models                             │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────┐          │
│  │ GoodnotesData                                    │          │
│  │  - pages: [PageData]                             │          │
│  │  - metadata: [String: String]                    │          │
│  └──────────────────────────────────────────────────┘          │
│                                                                  │
│  ┌──────────────────────────────────────────────────┐          │
│  │ PageData                                         │          │
│  │  - pageNumber: Int                               │          │
│  │  - image: UIImage?                               │          │
│  │  - text: String                                  │          │
│  │  - annotations: [Annotation]                     │          │
│  └──────────────────────────────────────────────────┘          │
│                                                                  │
│  ┌──────────────────────────────────────────────────┐          │
│  │ Annotation                                       │          │
│  │  - type: AnnotationType                          │          │
│  │  - text: String                                  │          │
│  │  - position: CGRect                              │          │
│  └──────────────────────────────────────────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         iOS Frameworks                          │
├─────────────────────────────────────────────────────────────────┤
│  Foundation  │  UIKit  │  SwiftUI  │  PDFKit  │  UTI           │
└─────────────────────────────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════════

Data Flow:
──────────

1. User selects file
   FilePickerView → selectedFileURL
   
2. User clicks Convert
   ContentView → DispatchQueue (background)
   
3. Parse GoodNotes file
   GoodnotesParser.parse(fileURL) → GoodnotesData
   
4. Convert to formats
   PDFConverter.convert(data) → PDF Data
   MarkdownConverter.convert(data) → Markdown String
   
5. Show export options
   ExportView → iOS Share Sheet → Save/Share

═══════════════════════════════════════════════════════════════════

Threading Model:
────────────────

Main Thread:
- UI Updates
- User Interactions
- Sheet Presentations

Background Thread:
- File I/O
- Parsing
- Conversion
- Image Processing

═══════════════════════════════════════════════════════════════════

Security Layers:
────────────────

┌─────────────────────────────────────┐
│    iOS Sandbox (App Container)      │
│  ┌───────────────────────────────┐  │
│  │   Document Picker (Secure)    │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │   Temporary Directory         │  │
│  │   (Auto Cleanup with defer)   │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │   Share Sheet (iOS System)    │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘

No Network Access ✓
No Third-Party SDKs ✓
All Processing Local ✓
```

## Component Responsibilities

### UI Layer (Views)
- **ContentView**: Main orchestration, user interaction
- **FilePickerView**: iOS Document Picker integration
- **ExportView**: Export options and sharing

### Business Logic
- **GoodnotesParser**: File parsing and data extraction
- **PDFConverter**: PDF generation from parsed data
- **MarkdownConverter**: Markdown formatting from parsed data

### Data Layer
- **GoodnotesData**: Container for all parsed information
- **PageData**: Individual page representation
- **Annotation**: Annotation metadata

## Technology Stack

| Layer | Technologies |
|-------|-------------|
| UI | SwiftUI, UIKit (Document Picker) |
| Logic | Swift 5.9, Foundation |
| Data | Codable, Swift Structs |
| Export | PDFKit, FileManager |
| Threading | DispatchQueue, async/await ready |

## File Organization

```
GoodnotesConverter/
├── App Entry
│   └── GoodnotesConverterApp.swift
├── Views
│   ├── ContentView.swift
│   ├── FilePickerView.swift
│   └── ExportView.swift
├── Business Logic
│   ├── GoodnotesParser.swift
│   ├── PDFConverter.swift
│   └── MarkdownConverter.swift
├── Resources
│   ├── Assets.xcassets/
│   └── Info.plist
└── Configuration
    └── GoodnotesConverter.xcodeproj/
```
