//
//  TestSummary.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 08/05/2025.
//
// View displaying a summary of the device info and test results, with PDF export option
//

import SwiftUI

struct TestSummaryView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel  /// Access to test results overview

    @State private var showShareSheet = false  /// Controls display of the share sheet
    @State private var pdfData: Data?  /// Stores the generated PDF data

    /// Get the latest result for each test type, sorted alphabetically
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
                
                /// Device Summary
                Text("Device Summary")
                    .font(.title)
                    .bold()
                
                Text("Model: \(DeviceInfoService.readableModelName())")
                Text("Name: \(UIDevice.current.name)")
                Text("OS: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
                
                Divider()
                
                /// Test Status
                Text("Test Status")
                    .font(.headline)
                
                let passed = latestResults.filter { $0.passed }.count
                let failed = latestResults.filter { !$0.passed }.count
                
                Text("Passed: \(passed)")
                Text("Failed: \(failed)")
                
                Divider()
                
                /// Individual Test Results
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
                
                /// Export as PDF Button
                SecondaryButton(title: "Export as PDF") {
                    let pageSize = CGSize(width: 612, height: 792) /// A4 size

                    /// Render the TestSummaryView into a PDF using ViewRenderer
                    ViewRenderer.render(view: TestSummaryView().environmentObject(testOverviewVM), size: pageSize) { data in
                        guard let data = data else {
                            print("Failed to generate PDF")
                            return
                        }
                        
                        /// Save the generated PDF data in state
                        self.pdfData = data

                        /// Show the share sheet after rendering is done
                        DispatchQueue.main.async {
                            self.showShareSheet = true
                        }

                        /// Create a file name based on the current timestamp
                        let fileName = "TestSummary-\(Int(Date().timeIntervalSince1970)).pdf"
                        
                        /// Get the Documents directory URL where the file will be saved
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let fileURL = documentsURL.appendingPathComponent(fileName)

                        do {
                            /// Attempt to write the PDF data to disk
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
