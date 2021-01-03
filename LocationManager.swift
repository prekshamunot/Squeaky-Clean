//
//  LocationManager.swift
//  SqueakyClean
//
//  Created by Preksha Munot on 8/9/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
private let locationManager = CLLocationManager()
override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.startUpdatingLocation()
    self.locationManager.allowsBackgroundLocationUpdates = true
    self.locationManager.pausesLocationUpdatesAutomatically = false
    
    let geofenceRegionCenter = CLLocationCoordinate2D(
        latitude: Model().latitude,
        longitude: Model().longitude
    )
    
    let geofenceRegion = CLCircularRegion(
        center: geofenceRegionCenter,
        radius: 100,
        identifier: "UniqueIdentifier"
    )
    
    geofenceRegion.notifyOnEntry = true
    geofenceRegion.notifyOnExit = false
    
    self.locationManager.startMonitoring(for: geofenceRegion)
    
    }
}
