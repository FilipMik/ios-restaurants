//
//  LocationService.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationServiceResult<T> {
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject {
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    var newLocation: ((LocationServiceResult<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?
    
    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func requestLocationAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        manager.requestLocation()
    }
    
    func getCoordinates() -> CLLocation? {
        return manager.location
    }
    
    func getDistanceBetweenLocations(
        loc1Long: Double, loc1Lat: Double,
        loc2Long: Double, loc2Lat: Double) -> Double {
        
        let location1 = CLLocation(latitude: loc1Lat, longitude: loc1Long)
        let location2 = CLLocation(latitude: loc2Lat, longitude: loc2Long)
        
        return location1.distance(from: location2)
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .notDetermined, .denied:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)

        }
    }
}
