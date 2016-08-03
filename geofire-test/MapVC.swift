//
//  ViewController.swift
//  geofire-test
//
//  Created by Amadeu Andrade on 02/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Firebase
import GeoFire
import MapKit

class MapVC: UIViewController {
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 10000
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    
    
}

