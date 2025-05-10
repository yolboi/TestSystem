//
//  LocationTestService.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 10/05/2025.
//

import Foundation
import CoreLocation
import MapKit

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationError: Error?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.locationError = error
        }
    }
    
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
