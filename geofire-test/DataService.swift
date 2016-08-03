//
//  DataService.swift
//  geofire-test
//
//  Created by Amadeu Andrade on 02/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation
import Firebase
import GeoFire
import CoreLocation

class DataService {

    static let ds = DataService()
    
    private let _REF_BASE = FIRDatabase.database().reference()
    private let _REF_GEOFIRE = GeoFire(firebaseRef: FIRDatabase.database().reference())
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_GEOFIRE: GeoFire {
        return _REF_GEOFIRE
    }
    
    var REF_PHOTOS: FIRDatabaseReference {
        return _REF_BASE.child("photos")
    }

    
    func createFirebasePhotoWithLocation(key: FIRDatabaseReference, photo: String, coord: CLLocationCoordinate2D) {
        //KEY WILL BE NEEDED TO STORE WITH GEOFIRE
        //create new entry/key
        //let photoKey = REF_PHOTOS.childByAutoId()
    
        //add info to entry/key
        let infoDict = [
            "photo" : photo,
            "coords" : ["lat" : coord.latitude, "long" : coord.longitude]
        ]
        key.setValue(infoDict)
    }
    
    func saveToGeoFire(location: CLLocation, firebaseKey: String) {
        _REF_GEOFIRE.setLocation(location, forKey: firebaseKey) { (error) in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                print("Saved location successfully!")
            }
        }
    }
    
}
