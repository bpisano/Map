//
//  MapViewController.swift
//  Map
//
//  Created by Benjamin Pisano on 26/01/2018.
//  Copyright © 2018 Snopia. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {
    func set(_ type: MKMapType) {
        self.mapType = type
    }
    
    func zoomOn(point: MKPointAnnotation) {
        var region = MKCoordinateRegionMakeWithDistance(point.coordinate, 500, 500)
        
        region.center.latitude = point.coordinate.latitude
        region.center.longitude = point.coordinate.longitude
        self.setRegion(region, animated: true)
    }
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapSegmented: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    var userCoordinate: CLLocationCoordinate2D?
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setupMap()
    }
    
    
    //////////////////////////////
    // MARK: - Location Manager //
    //////////////////////////////
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        mapView.showsUserLocation = true
    }
    
    
    /////////////////////////
    // MARK: - Map Manager //
    /////////////////////////

    private func setupMap() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        mapSegmented.selectedSegmentIndex = 2
        mapView.delegate = self
        mapView.set(.hybrid)
        setPin()
    }
    
    private func setPin() {
        let point = MKPointAnnotation()
        
        point.coordinate = place == nil ? CLLocationCoordinate2DMake(45.739368, 4.817544) : place!.coordinate
        point.title = place == nil ? "Le 101" : place!.title
        point.subtitle = place == nil ? "A cool place to be" : place!.description
        mapView.addAnnotation(point)
        mapView.zoomOn(point: point)
    }
    
    @IBAction func displayLocation(_ sender: Any) {
        let point = MKPointAnnotation()
        
        point.coordinate = mapView.userLocation.coordinate
        mapView.zoomOn(point: point)
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        switch mapSegmented.selectedSegmentIndex {
        case 0:
            mapView.set(.standard)
        case 1:
            mapView.set(.satellite)
        case 2:
            mapView.set(.hybrid)
        default:
            mapView.set(.standard)
        }
    }
}
