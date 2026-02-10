//
//  LocationService.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/7.
//

import UIKit
import Foundation
import CoreLocation

class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var isLocating = false
    
    var success: (([String: Any]) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func start() {
        guard !isLocating else { return }
        isLocating = true
        
        let status = CLLocationManager().authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            isLocating = false
            self.success?([:])
            
        @unknown default:
            isLocating = false
        }
    }
    
    func stop() {
        isLocating = false
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        } else if status == .denied {
            isLocating = false
            self.success?([:])
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
        UserDefaults.standard.synchronize()
        
        stop()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            guard let place = placemarks?.first else {
                return
            }
            
            let result = LocationResult(
                eurish: place.administrativeArea ?? "",
                schoolably: place.isoCountryCode ?? "",
                widear: place.country ?? "",
                amatproof: place.name ?? "",
                regionlet: "\(location.coordinate.latitude)",
                fidel: "\(location.coordinate.longitude)",
                me: place.locality ?? "",
                degreeing: place.subLocality ?? ""
            )
            
            self.success?(result.toJSON())
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        stop()
        self.success?([:])
    }
}

struct LocationResult {
    var eurish: String
    var schoolably: String
    var widear: String
    var amatproof: String
    var regionlet: String
    var fidel: String
    var me: String
    var degreeing: String
}

extension LocationResult {
    
    func toJSON() -> [String: Any] {
        return [
            "eurish": eurish,
            "schoolably": schoolably,
            "widear": widear,
            "amatproof": amatproof,
            "regionlet": regionlet,
            "fidel": fidel,
            "me": me,
            "degreeing": degreeing
        ]
    }
}
