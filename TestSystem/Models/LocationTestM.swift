//
//  LocationTestM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 24/04/2025.
//
// Address and AnnotationItem.
// They are used for handling addresses and map annotations, helping to represent locations and pins on a map view

import Foundation
import MapKit

struct Address: Identifiable {
    let id = UUID() ///identifier for each address
    let title: String
    let subtitle: String
}

/// custom marker on map
struct AnnotationItem: Identifiable {
  let id: String
  let coordinate: CLLocationCoordinate2D ///Stores the location as a latitude and longitude (from MapKit)
  let title: String
}
