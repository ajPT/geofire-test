//
//  MapVC+LocationManager.swift
//  geofire-test
//
//  Created by Amadeu Andrade on 03/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation

extension MapVC: CLLocationManagerDelegate {

    //MARK: - Authorization
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.requestLocation() //iOS 9
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: - Set Initial Area
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.first {
            centerMapOnLocation(location)
        }
    }
    
    //AUX
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    
    //MARK: - Necessary for delegation...
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }

}