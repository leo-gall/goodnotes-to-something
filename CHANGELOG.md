# Changelog

All notable changes to the GoodNotes Converter project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-10-22

### Added
- Initial iOS app implementation
- GoodNotes file parser
- PDF conversion functionality
- Markdown conversion functionality
- SwiftUI-based user interface
- File picker integration for selecting GoodNotes files
- Export functionality with iOS Share Sheet
- Support for single and dual format export (PDF and/or Markdown)
- Comprehensive documentation:
  - README.md with project overview
  - DEVELOPER.md with technical documentation
  - QUICKSTART.md with user guide
  - SECURITY.md with security analysis
- MIT License
- .gitignore for Xcode projects

### Features
- 📱 Native iOS app with SwiftUI
- 📄 Convert GoodNotes files to PDF
- 📝 Convert GoodNotes files to Markdown
- 🎨 Modern, intuitive user interface
- 📤 Easy export via iOS Share Sheet
- 🔄 Multi-page document support
- 📊 Metadata extraction and preservation
- 🔒 Privacy-focused (all processing done locally)
- ⚡ Asynchronous conversion (non-blocking UI)

### Technical Details
- Minimum iOS Version: 16.0
- Swift Version: 5.0
- Xcode Version: 15.0
- Architecture: MVVM with SwiftUI
- Frameworks: Foundation, UIKit, SwiftUI, PDFKit, UniformTypeIdentifiers

### Security
- Sandboxed file access
- Proper temporary file cleanup
- No third-party dependencies
- No network communication
- Local-only processing

## [Unreleased]

### Planned Features
- [ ] Batch conversion (multiple files)
- [ ] OCR for handwritten notes
- [ ] Cloud storage integration (iCloud, Dropbox, etc.)
- [ ] Customizable export templates
- [ ] watchOS companion app
- [ ] macOS Catalyst version
- [ ] Dark mode optimization
- [ ] iPad-specific UI enhancements
- [ ] Unit and UI tests
- [ ] Localization (multiple languages)

### Known Issues
- GoodNotes format parsing is limited (proprietary format)
- Handwritten content exported as images (no OCR)
- Complex annotations may not be fully preserved

---

## Version History

### Version Numbering
- Major version: Breaking changes
- Minor version: New features (backwards compatible)
- Patch version: Bug fixes and minor improvements

### Support
For issues, feature requests, or contributions, please visit:
https://github.com/leo-gall/goodnotes-to-something
