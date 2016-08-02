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
    
}