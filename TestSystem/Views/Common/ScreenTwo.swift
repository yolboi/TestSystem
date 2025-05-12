//
//  ScreenTwo.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 20/02/2025.
//
// View displaying device information and a log of all completed tests
//

import SwiftUI

struct ScreenTwo: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel /// Provides access to the list of test results

    let name = UIDevice.current.name  /// Device name (e.g., "John's iPhone")
    let systemName = UIDevice.current.systemName /// Operating system name (e.g., "iOS")
    let systemVersion = UIDevice.current.systemVersion /// Operating system version (e.g., "17.4")
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                /// About Device Section
                Text("About Device")
                    .font(.title)
                    .bold()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Model: \(DeviceInfoService.readableModelName())")
                    Text("Name: \(name)")
                    Text("OS: \(systemName) \(systemVersion)")
                }

                Divider()

                /// Test Log Section
                Text("Test Log")
                    .font(.title2)
                    .bold()

                ForEach(testOverviewVM.sortedResults, id: \.id) { result in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(result.testType.rawValue.capitalized)
                                .font(.headline)

                            Text(result.timestamp, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)

                            if let note = result.notes {
                                Text(note)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }

                        Spacer()

                        Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(result.passed ? .green : .red)
                            .imageScale(.large)
                    }
                    .padding(.vertical, 8)

                    Divider()
                }

                /// Reset All Tests Button
                Button(role: .destructive) {
                    testOverviewVM.clearAll()
                } label: {
                    Text("Reset All Tests")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(8)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Test Overview")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ScreenTwo()
        .environmentObject(TestOverviewViewModel())
}
