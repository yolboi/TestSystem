//
//  Location.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//
//  Provides a location test by allowing users to search for a destination, view their route, and verify GPS accuracy.
//


import SwiftUI
import MapKit

struct LocationTest: View {

    @EnvironmentObject var navModel: NavigationModel
    @StateObject private var vm: LocationTestViewModel
    @State private var locationManager = CLLocationManager() /// Core Location manager
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var searchDebounceTask: DispatchWorkItem?  /// Used to debounce search input

    init(locationService: LocationService, testOverviewVM: TestOverviewViewModel) {
        _vm = StateObject(wrappedValue: LocationTestViewModel(locationService: locationService, testOverviewVM: testOverviewVM))
    }

    var body: some View {
        VStack {
            /// Search field for destination
            TextField("Enter address", text: $vm.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: vm.searchText) {
                    /// Cancel previous debounce task if typing continues
                    searchDebounceTask?.cancel()

                    guard !vm.searchText.isEmpty else { return }

                    /// Create a new debounce task
                    let task = DispatchWorkItem {
                        vm.search()
                    }
                    searchDebounceTask = task
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
                }

            /// Search results list
            List(vm.searchResults, id: \.self) { item in
                Button(action: {
                    vm.selectDestination(destinationItem: item)
                    hideKeyboard()
                }) {
                    VStack(alignment: .leading) {
                        Text(item.name ?? "Unknown place")
                            .font(.headline)
                        if let address = item.placemark.title {
                            Text(address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .disabled(vm.userLocation == nil)
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: 200)

            /// Map view showing user location, destination, and route
            Map(position: $cameraPosition) {
                UserAnnotation()

                if let destination = vm.destinationCoordinate {
                    Marker("Destination", coordinate: destination)
                }

                if let route = vm.route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 5)
                }
            }
            .ignoresSafeArea()

            Spacer()

            /// Action buttons depending on test result
            if vm.testCompleted {
                DefaultButton(title: "Test Passed – Go Back") {
                    navModel.path.removeLast()
                }
                .padding()
            } else if vm.testFailed {
                SecondaryButton(title: "Test Failed – Go Back") {
                    navModel.path.removeLast()
                }
                .padding()
            }
        }
        .onAppear {
            /// Request location authorization and set initial map region
            locationManager.requestWhenInUseAuthorization()
            if let location = locationManager.location?.coordinate {
                cameraPosition = .region(MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000))
            }
        }
    }
}

/// Extension to hide the keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
