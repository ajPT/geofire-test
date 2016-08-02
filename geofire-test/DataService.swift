//
//  DataService.swift
//  geofire-test
//
//  Created by Amadeu Andrade on 02/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation
import Firebase

class DataService {

    static let ds = DataService()
    
    private var _REF_BASE = FIRDatabase.database().reference()
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
}