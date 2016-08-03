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

class MapVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 10000
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
    }

    @IBAction func onDropBtnPressed(sender: UIBarButtonItem) {
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let thumbnail = resizeImage(image, targetSize: CGSizeMake(400.0, 400.0))

        let imgData = UIImagePNGRepresentation(thumbnail)!
        
        let base64EncodedImage = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let userCurrentLocation = map.userLocation.location!
        let coords = map.userLocation.coordinate
        
        let newKey = DataService.ds.REF_PHOTOS.childByAutoId()
        let newKeyStr = newKey.key
        //Save to Firebase
        DataService.ds.createFirebasePhotoWithLocation(newKey, photo: base64EncodedImage, coord: coords)
        //Save to Geofire
        DataService.ds.saveToGeoFire(userCurrentLocation, firebaseKey: newKeyStr)
        
    }
    
    
    //or use UIImage-Resize 1.0.1 framework
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

