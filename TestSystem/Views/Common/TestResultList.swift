//
//  TestResultList.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 02/05/2025.
//

/*
import SwiftUI

struct TestResultListView: View {
    @EnvironmentObject var testOverviewVM: TestOverviewViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Testoversigt")
                .font(.largeTitle)
                .padding(.bottom)

            List(testOverviewVM.sortedResults) { result in
                HStack {
                    Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(result.passed ? .green : .red)

                    VStack(alignment: .leading) {
                        Text(result.testType.localizedName)
                            .font(.headline)
                        Text(formattedDate(result.timestamp))
                            .font(.caption)
                            .foregroundColor(.gray)

                        if let note = result.notes {
                            Text(note)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
*/
