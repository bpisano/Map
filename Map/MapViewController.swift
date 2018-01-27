//
//  MapViewController.swift
//  Map
//
//  Created by Benjamin Pisano on 26/01/2018.
//  Copyright © 2018 Snopia. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
    }

    private func setupMap() {
        mapView.mapType = .hybrid
        setPin()
    }
    
    private func setPin() {
        let point = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2DMake(48.862725, 2.287592000000018)
        
        point.coordinate = coordinate
        mapView.addAnnotation(point)
        zoomOn(point: point)
    }
    
    private func zoomOn(point: MKPointAnnotation) {
        var region = MKCoordinateRegion()
        
        region.center.latitude = point.coordinate.latitude
        region.center.longitude = point.coordinate.longitude
        mapView.setRegion(region, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
