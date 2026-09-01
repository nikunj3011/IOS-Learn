//
//  LocationManager.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-07-08.
//

import Foundation
import CoreLocation
import SwiftUI // <--- ADD THIS
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var isConnectedToGPS = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationAccess() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    // Delegate methods...
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async { // UI updates must be on Main Thread
            if !locations.isEmpty {
                self.isConnectedToGPS = true
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            print("Location failed: \(error.localizedDescription)")
            self.isConnectedToGPS = false
        }
    }
}
