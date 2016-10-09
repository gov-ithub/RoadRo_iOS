//
//  LocationTracker.swift
//  LocationTracker
//
//  Created by mihai on 02/08/16.
//  Copyright © 2016 mihai. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

enum LocationTrackerError: Error {
  case CantStartTracker(authStatus: CLAuthorizationStatus)
}

class LocationTracker: NSObject {
  
  static var instance = LocationTracker()
  
  fileprivate lazy var geocoder: CLGeocoder = {
    return CLGeocoder()
  }()
  
  fileprivate lazy var locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.distanceFilter = kCLDistanceFilterNone
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.allowsBackgroundLocationUpdates = false
    manager.delegate = self
    return manager
  }()
  
  fileprivate var lastKnownLocation: CLLocation?
  
  var userLocation: CLLocation? {
    get {
      return lastKnownLocation
    }
  }
  
  override init() {
    super.init()
  }
  
  /**
   Start location tracker
   - Throws: `LocationTrackerError.CantStartTracker` if the authStatus is either `.restricted` or `.denied`
   */
  func startTracker() throws {
    let authStatus = CLLocationManager.authorizationStatus()
    if authStatus == .restricted || authStatus == .denied {
      throw LocationTrackerError.CantStartTracker(authStatus: authStatus)
    }
    
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  func getLocationAddress(completion: ((_ address: String?) -> Void)?) {
    guard let coord = self.userLocation else {
      completion?(nil)
      return
    }
    
    self.geocoder.reverseGeocodeLocation(coord) { (placemarks, _) in
      var address: String? = nil
      
      if let placemark = placemarks?.first {
        var strings: [String] = []
        if let value = placemark.thoroughfare {
          strings.append(value)
        }
        if let value = placemark.subThoroughfare {
          strings.append(value)
        }
        if let value = placemark.locality {
          strings.append(value)
        }
        address = (strings as NSArray).componentsJoined(by: " ")
      }
      
      DispatchQueue.main.async {
        completion?(address)
      }
    }
  }
}

extension LocationTracker: CLLocationManagerDelegate {
  
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.lastKnownLocation = locations.last
  }
}
