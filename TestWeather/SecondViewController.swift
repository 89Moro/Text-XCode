//
//  SecondViewController.swift
//  TestWeather
//
//  Created by Ospite on 12/05/17.
//  Copyright © 2017 Ospite. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    @IBOutlet weak var lblLatitude: UITextField!
    @IBOutlet weak var lblLongitude: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var mvMappa: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var latitude:Int = 0
    var longitude:Int = 0
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mvMappa.delegate = self
        mvMappa.showsUserLocation = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnStart_touchUpPressed(_ sender: UIButton) {
        defaults.set(Int(lblLatitude.text!), forKey: "Latitude")
        defaults.set(Int(lblLongitude.text!), forKey: "Longitude")
        
    }



}

