import Foundation

class MarkdownConverter {
    enum ConversionError: Error {
        case noPages
    }
    
    func convert(parsedData: GoodnotesData) throws -> String {
        guard !parsedData.pages.isEmpty else {
            throw ConversionError.noPages
        }
        
        var markdown = ""
        
        // Add metadata header
        markdown += "# \(parsedData.metadata["title"] ?? parsedData.metadata["fileName"] ?? "Converted Document")\n\n"
        
        if let author = parsedData.metadata["author"] {
            markdown += "**Author:** \(author)\n\n"
        }
        
        if let created = parsedData.metadata["created"] {
            markdown += "**Created:** \(created)\n\n"
        }
        
        if let convertedDate = parsedData.metadata["convertedDate"] {
            markdown += "**Converted:** \(convertedDate)\n\n"
        }
        
        markdown += "---\n\n"
        
        // Add pages
        for page in parsedData.pages {
            markdown += "## Page \(page.pageNumber)\n\n"
            
            if page.image != nil {
                markdown += "*[Image content - Page \(page.pageNumber)]*\n\n"
            }
            
            if !page.text.isEmpty {
                markdown += page.text + "\n\n"
            }
            
            // Add annotations if any
            if !page.annotations.isEmpty {
                markdown += "### Annotations\n\n"
                for (index, annotation) in page.annotations.enumerated() {
                    markdown += "\(index + 1). "
                    
                    switch annotation.type {
                    case .text:
                        markdown += "**Note:** "
                    case .highlight:
                        markdown += "**Highlight:** "
                    case .drawing:
                        markdown += "**Drawing:** "
                    }
                    
                    markdown += annotation.text + "\n"
                }
                markdown += "\n"
            }
            
            markdown += "---\n\n"
        }
        
        // Add footer
        markdown += "\n*Converted from GoodNotes using GoodNotes Converter*\n"
        
        return markdown
    }
}
