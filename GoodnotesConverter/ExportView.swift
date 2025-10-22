import SwiftUI

struct ExportView: View {
    let pdfData: Data
    let markdownText: String
    let fileName: String
    @Environment(\.presentationMode) var presentationMode
    @State private var showShareSheet = false
    @State private var shareItem: ShareItem?
    @State private var exportMessage: String?
    
    enum ShareItem {
        case pdf
        case markdown
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                    .padding(.top, 30)
                
                Text("Conversion Complete!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Your GoodNotes file has been successfully converted")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: { exportPDF() }) {
                        HStack {
                            Image(systemName: "doc.fill")
                            Text("Export as PDF")
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: { exportMarkdown() }) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                            Text("Export as Markdown")
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: { exportBoth() }) {
                        HStack {
                            Image(systemName: "doc.on.doc.fill")
                            Text("Export Both")
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                if let message = exportMessage {
                    Text(message)
                        .font(.callout)
                        .foregroundColor(.green)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Export")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showShareSheet) {
                if let item = shareItem {
                    switch item {
                    case .pdf:
                        ShareSheet(items: [createPDFFile()])
                    case .markdown:
                        ShareSheet(items: [createMarkdownFile()])
                    }
                }
            }
        }
    }
    
    private func exportPDF() {
        shareItem = .pdf
        showShareSheet = true
    }
    
    private func exportMarkdown() {
        shareItem = .markdown
        showShareSheet = true
    }
    
    private func exportBoth() {
        let pdfURL = createPDFFile()
        let markdownURL = createMarkdownFile()
        
        let activityVC = UIActivityViewController(
            activityItems: [pdfURL, markdownURL],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            var topVC = rootVC
            while let presented = topVC.presentedViewController {
                topVC = presented
            }
            activityVC.popoverPresentationController?.sourceView = topVC.view
            topVC.present(activityVC, animated: true)
        }
    }
    
    private func createPDFFile() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let pdfURL = tempDir.appendingPathComponent("\(fileName).pdf")
        try? pdfData.write(to: pdfURL)
        return pdfURL
    }
    
    private func createMarkdownFile() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let markdownURL = tempDir.appendingPathComponent("\(fileName).md")
        try? markdownText.write(to: markdownURL, atomically: true, encoding: .utf8)
        return markdownURL
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
