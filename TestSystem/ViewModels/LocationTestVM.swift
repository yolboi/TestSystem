//
//  LocationTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 24/04/2025.
//

import Foundation
import MapKit

@MainActor
class LocationTestViewModel: ObservableObject {
    @Published var route: MKRoute?
    @Published var searchText = ""
    @Published var destinationCoordinate: CLLocationCoordinate2D?
    @Published var testFailed: Bool = false
    @Published var searchResults: [MKMapItem] = []

    private let locationService: LocationService
    private let testResultService: TestResultService
    private let testOverviewVM: TestOverviewViewModel

    init(locationService: LocationService, testOverviewVM: TestOverviewViewModel, testResultService: TestResultService = TestResultService()) {
        self.locationService = locationService
        self.testOverviewVM = testOverviewVM
        self.testResultService = testResultService
    }

    var userLocation: CLLocationCoordinate2D? {
        locationService.userLocation
    }

    var testCompleted: Bool {
        !testFailed && destinationCoordinate != nil
    }

    func search() {
        guard let _ = userLocation else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            if let items = response?.mapItems {
                self.searchResults = items
            } else if let error = error {
                print("Search error: \(error.localizedDescription)")
            }
        }
    }

    func selectDestination(destinationItem: MKMapItem) {
        guard let userLocation = userLocation else { return }

        let destination = destinationItem.placemark.coordinate
        self.destinationCoordinate = destination
        fetchRoute(from: userLocation, to: destination)
    }

    private func fetchRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .walking

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            if let route = response?.routes.first {
                self.route = route
                print("Distance: \(route.distance) meters")
                self.evaluateTest(distance: route.distance)
            } else if let error = error {
                print("Route error: \(error.localizedDescription)")
            }
        }
    }

    private func evaluateTest(distance: CLLocationDistance) {
        testFailed = distance > 50
        locationService.saveLocationTestResult(passed: !testFailed, to: testOverviewVM)
    }
}
