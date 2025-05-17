//
//  pdfSigai.swift
//  SIGAI
//
//  Created by Ainal syazwan Itamta on 22/04/2025.
//

import SwiftUI
import PDFKit

struct PDFViewerView: View {
    var body: some View {
        if let pdfURL = Bundle.main.url(forResource: "SIGAI", withExtension: "pdf") {
            PDFKitView(url: pdfURL)
                .navigationTitle("SIGAI.pdf")
                .edgesIgnoringSafeArea(.all)
        } else {
            Text("PDF not found")
                .foregroundColor(.red)
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
