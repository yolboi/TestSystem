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
    
    @Published var route: MKRoute? /// Stores the calculated route between user and destination
    @Published var searchText = "" /// Text input for search queries
    @Published var destinationCoordinate: CLLocationCoordinate2D? /// The selected destination's coordinates
    @Published var testFailed: Bool = false  /// Indicates if the location test has failed
    @Published var searchResults: [MKMapItem] = [] /// Stores the search results from map search

    
    private let locationService: LocationService /// get user location updates
    private let testResultService: TestResultService /// handle saving test results
    private let testOverviewVM: TestOverviewViewModel /// collect and manage all test results

    ///Initializer
    init(locationService: LocationService, testOverviewVM: TestOverviewViewModel, testResultService: TestResultService = TestResultService()) {
        self.locationService = locationService
        self.testOverviewVM = testOverviewVM
        self.testResultService = testResultService
    }

    /// gets the user's current location
    var userLocation: CLLocationCoordinate2D? {
        locationService.userLocation
    }

    /// checks if the test is completed
    var testCompleted: Bool {
        !testFailed && destinationCoordinate != nil
    }


    /// Searches for locations based on the search text
    func search() {
        guard let _ = userLocation else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            if let items = response?.mapItems {
                self.searchResults = items   /// Save search results
            } else if let error = error {
                print("Search error: \(error.localizedDescription)")
            }
        }
    }

    // Selects a destination from search results and starts fetching the route
    func selectDestination(destinationItem: MKMapItem) {
        guard let userLocation = userLocation else { return }

        let destination = destinationItem.placemark.coordinate
        self.destinationCoordinate = destination
        fetchRoute(from: userLocation, to: destination)
    }

    /// Calculates a route from the user's location to the selected destination
    private func fetchRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .walking

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            if let route = response?.routes.first {
                self.route = route            // Save the found route
                print("Distance: \(route.distance) meters")
                self.evaluateTest(distance: route.distance)  // Evaluate if test passes based on distance
            } else if let error = error {
                print("Route error: \(error.localizedDescription)")
            }
        }
    }

    // Evaluates if the route is acceptable (less than or equal to 50 meters)
    private func evaluateTest(distance: CLLocationDistance) {
        testFailed = distance > 50 /// margin of error might be increaced 
        locationService.saveLocationTestResult(passed: !testFailed, to: testOverviewVM)
    }
}
