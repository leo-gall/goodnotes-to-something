import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var selectedFileURL: URL?
    @State private var showFilePicker = false
    @State private var showExportView = false
    @State private var convertedPDF: Data?
    @State private var convertedMarkdown: String?
    @State private var isConverting = false
    @State private var errorMessage: String?
    @State private var selectedFileName: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "doc.text.image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 50)
                
                Text("GoodNotes Converter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Convert GoodNotes files to PDF and Markdown")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                if let fileName = selectedFileURL?.lastPathComponent {
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Selected: \(fileName)")
                                .font(.callout)
                        }
                        
                        Button(action: convertFile) {
                            HStack {
                                if isConverting {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                }
                                Text(isConverting ? "Converting..." : "Convert")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isConverting ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(isConverting)
                        .padding(.horizontal)
                    }
                } else {
                    Button(action: { showFilePicker = true }) {
                        HStack {
                            Image(systemName: "folder.badge.plus")
                            Text("Select GoodNotes File")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                if let error = errorMessage {
                    Text(error)
                        .font(.callout)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                Text("Supports .goodnotes files")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 30)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showFilePicker) {
                FilePickerView(selectedFileURL: $selectedFileURL)
            }
            .sheet(isPresented: $showExportView) {
                if let pdfData = convertedPDF, let markdown = convertedMarkdown {
                    ExportView(pdfData: pdfData, markdownText: markdown, fileName: selectedFileName)
                }
            }
        }
    }
    
    private func convertFile() {
        guard let fileURL = selectedFileURL else { return }
        
        isConverting = true
        errorMessage = nil
        selectedFileName = fileURL.deletingPathExtension().lastPathComponent
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let parser = GoodnotesParser()
                let parsedData = try parser.parse(fileURL: fileURL)
                
                let pdfConverter = PDFConverter()
                let pdfData = try pdfConverter.convert(parsedData: parsedData)
                
                let markdownConverter = MarkdownConverter()
                let markdownText = try markdownConverter.convert(parsedData: parsedData)
                
                DispatchQueue.main.async {
                    self.convertedPDF = pdfData
                    self.convertedMarkdown = markdownText
                    self.isConverting = false
                    self.showExportView = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.isConverting = false
                    self.errorMessage = "Conversion failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
