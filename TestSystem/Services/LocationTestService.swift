//
//  LocationTestService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//
//  Provides location tracking and error reporting using CoreLocation.
//  Publishes updates to views and saves location test results.
//

import Foundation
import CoreLocation
import MapKit

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D? ///Stores the user’s latest known location
    @Published var locationError: Error? ///Stores any error encountered during location updates
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() ///Requests permission to access location when the app is in use
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation() ///Starts updating the location
    }
    
    ///Takes the first location from the array and updates userLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }
    
    ///Called when location services encounter an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.locationError = error
        }
    }
    
    ///TestResult object
    func saveLocationTestResult(passed: Bool, to viewModel: TestOverviewViewModel) {
        let result = TestResult(
            testType: .location,
            passed: passed,
            timestamp: Date(),
            notes: passed ? nil : "Distance to destination was too far (> 50m)",
            confirmed: true
        )
        viewModel.addResult(result)
    }
}
