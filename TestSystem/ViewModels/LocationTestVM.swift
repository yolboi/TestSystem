//
//  LocationTestVM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 24/04/2025.
//

import Foundation
import MapKit
import Combine


import SwiftUI
import MapKit

// ViewModel
@MainActor
class MapViewModel: ObservableObject {
    @Published var route: MKRoute?
    @Published var searchText = ""
    @Published var destinationCoordinate: CLLocationCoordinate2D?
    @Published var testFailed: Bool = false
    @Published var searchResults: [MKMapItem] = []
    
    func search(from userLocation: CLLocationCoordinate2D) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let items = response?.mapItems {
                self.searchResults = items
            } else if let error = error {
                print("Fejl i søgning: \(error.localizedDescription)")
            }
        }
    }
    
    func selectDestination(from userLocation: CLLocationCoordinate2D, destinationItem: MKMapItem) {
        let destination = destinationItem.placemark.coordinate
        self.destinationCoordinate = destination
        fetchRoute(from: userLocation, to: destination)
    }
    
    func fetchRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                print("Distance til destination: \(route.distance) meter")
                
                if route.distance > 50 {
                    self.testFailed = true
                } else {
                    self.testFailed = false
                }
            } else if let error = error {
                print("Fejl i rute: \(error.localizedDescription)")
            }
        }
    }
}
