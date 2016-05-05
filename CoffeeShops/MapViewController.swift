//
//  MapViewController.swift
//  CoffeeShops
//
//  Created by Yin Hua on 3/05/2016.
//  Copyright © 2016 Yin Hua. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    var lat:CLLocationDegrees = 0.0
    var lng:CLLocationDegrees = 0.0
    var addressString = ""
    
    private let regionRadius: CLLocationDistance = 1000
    
    
    @IBOutlet weak var mkMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      let centerLocation = CLLocation(latitude: lat, longitude: lng)//QBV
        
        
        
        // Do any additional setup after loading the view.
        self.centerMapOnLocation(centerLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Display Shop Location
    private func centerMapOnLocation(location: CLLocation) {
        
        //Set Region
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        self.mkMapView.setRegion(coordinateRegion, animated: false)
        
        //Pin on map
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = addressString
        
        self.mkMapView.addAnnotation(annotation)
        self.mkMapView.selectAnnotation(annotation, animated: true)//display address
        
    }

}
