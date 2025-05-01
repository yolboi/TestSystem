//
//  LocationTestM.swift
//  TestSystem
//
//  Created by Jarl Boyd Roest on 24/04/2025.
//

import Foundation
import MapKit

struct Address: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    //var coordinate: CLLocationCoordinate2D
}

struct AnnotationItem: Identifiable {
  // Skift fra UUID til String
  let id: String
  let coordinate: CLLocationCoordinate2D
  let title: String

    /*
  // Convenience initializer
 init(coordinate: CLLocationCoordinate2D, title: String) {
    self.id = UUID().uuidString
    self.coordinate = coordinate
   self.title = title
  }
    */
}
