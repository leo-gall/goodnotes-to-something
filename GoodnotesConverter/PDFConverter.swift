import Foundation
import UIKit
import PDFKit

class PDFConverter {
    enum ConversionError: Error {
        case noPages
        case pdfCreationFailed
    }
    
    func convert(parsedData: GoodnotesData) throws -> Data {
        guard !parsedData.pages.isEmpty else {
            throw ConversionError.noPages
        }
        
        let pdfMetaData = [
            kCGPDFContextCreator: "GoodNotes Converter",
            kCGPDFContextAuthor: parsedData.metadata["author"] ?? "Unknown",
            kCGPDFContextTitle: parsedData.metadata["title"] ?? parsedData.metadata["fileName"] ?? "Converted Document"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // Calculate page size based on first page with image, or use default
        let pageSize: CGRect
        if let firstImage = parsedData.pages.first?.image {
            pageSize = CGRect(origin: .zero, size: firstImage.size)
        } else {
            // Default A4 size in points (595 x 842)
            pageSize = CGRect(x: 0, y: 0, width: 595, height: 842)
        }
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageSize, format: format)
        
        let pdfData = renderer.pdfData { context in
            for page in parsedData.pages {
                context.beginPage()
                
                if let image = page.image {
                    // Draw the image to fill the page
                    let imageRect = CGRect(origin: .zero, size: image.size)
                    image.draw(in: imageRect)
                } else {
                    // Draw text content if no image
                    let textRect = pageSize.insetBy(dx: 50, dy: 50)
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .left
                    paragraphStyle.lineSpacing = 5
                    
                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 14),
                        .paragraphStyle: paragraphStyle,
                        .foregroundColor: UIColor.black
                    ]
                    
                    let attributedText = NSAttributedString(string: page.text, attributes: attributes)
                    attributedText.draw(in: textRect)
                }
                
                // Draw page number at the bottom
                let pageNumberText = "Page \(page.pageNumber)"
                let pageNumberAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10),
                    .foregroundColor: UIColor.gray
                ]
                let pageNumberSize = pageNumberText.size(withAttributes: pageNumberAttributes)
                let pageNumberRect = CGRect(
                    x: (pageSize.width - pageNumberSize.width) / 2,
                    y: pageSize.height - 30,
                    width: pageNumberSize.width,
                    height: pageNumberSize.height
                )
                pageNumberText.draw(in: pageNumberRect, withAttributes: pageNumberAttributes)
            }
        }
        
        return pdfData
    }
}
