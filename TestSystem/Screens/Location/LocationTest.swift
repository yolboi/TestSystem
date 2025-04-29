//
//  Location.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 23/04/2025.
//


import SwiftUI
import MapKit

struct MapScreen: View {
    @StateObject private var vm = MapViewModel()
    @State private var locationManager = CLLocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        VStack {
            TextField("Indtast adresse", text: $vm.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    if let userLocation = userLocation {
                        vm.search(from: userLocation)
                    }
                }
            
            // Viser søgeresultater
            List(vm.searchResults, id: \.self) { item in
                Button(action: {
                    if let userLocation = userLocation {
                        vm.selectDestination(from: userLocation, destinationItem: item)
                    }
                }) {
                    VStack(alignment: .leading) {
                        Text(item.name ?? "Ukendt sted")
                            .font(.headline)
                        if let address = item.placemark.title {
                            Text(address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .frame(maxHeight: 200) // Begræns hvor stor listen må blive
            
            if vm.testFailed {
                Text("❌ Testen fejlede: Distance større end 50 meter")
                    .foregroundColor(.red)
                    .padding()
            }
            
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
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
            if let location = locationManager.location?.coordinate {
                self.userLocation = location
                self.cameraPosition = .region(MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000))
            }
        }
    }
}
