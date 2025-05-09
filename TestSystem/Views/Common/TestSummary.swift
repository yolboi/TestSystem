//
//  TestSummary.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 08/05/2025.
//

import SwiftUI

struct TestSummaryView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel
    
    @State private var showShareSheet = false
    @State private var pdfData: Data?
    
    var latestResults: [TestResult] {
        Dictionary(grouping: testOverviewVM.results) { $0.testType }
            .compactMapValues { $0.sorted(by: { $0.timestamp > $1.timestamp }).first }
            .values
            .sorted(by: { $0.testType.rawValue < $1.testType.rawValue })
    }
    
    var body: some View {
        let latestResults: [TestResult] = {
            Dictionary(grouping: testOverviewVM.results) { $0.testType }
                .compactMapValues { $0.sorted(by: { $0.timestamp > $1.timestamp }).first }
                .values
                .sorted(by: { $0.testType.rawValue < $1.testType.rawValue })
        }()
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Device Summary")
                    .font(.title)
                    .bold()
                
                Text("Model: \(DeviceInfoService.readableModelName())")
                Text("Name: \(UIDevice.current.name)")
                Text("OS: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
                
                Divider()
                
                Text("Test Status")
                    .font(.headline)
                
                let passed = latestResults.filter { $0.passed }.count
                let failed = latestResults.filter { !$0.passed }.count
                
                Text("Passed: \(passed)")
                Text("Failed: \(failed)")
                
                Divider()
                
                ForEach(latestResults, id: \.id) { result in
                    HStack {
                        Text(result.testType.rawValue.capitalized)
                        Spacer()
                        Text(result.passed ? "Passed" : "Failed")
                            .foregroundColor(result.passed ? .green : .red)
                            .bold()
                    }
                }
                
                Spacer(minLength: 40)
                
                SecondaryButton(title: "Export as PDF") {
                    let pageSize = CGSize(width: 612, height: 792)

                    ViewRenderer.render(view: TestSummaryView().environmentObject(testOverviewVM), size: pageSize) { data in
                        guard let data = data else {
                            print("Failed to generate PDF")
                            return
                        }

                        self.pdfData = data

                        // Flyt showShareSheet herind – efter data er klar
                        DispatchQueue.main.async {
                            self.showShareSheet = true
                        }

                        // Valgfrit: Gem lokalt
                        let fileName = "TestSummary-\(Int(Date().timeIntervalSince1970)).pdf"
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let fileURL = documentsURL.appendingPathComponent(fileName)

                        do {
                            try data.write(to: fileURL)
                            print("PDF saved to: \(fileURL)")
                        } catch {
                            print("Failed to save PDF: \(error)")
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showShareSheet) {
            if let data = pdfData {
                ShareView(activityItems: [data])
            }
        }
    }
}
