//
//  ListTableViewController.swift
//  Map
//
//  Created by Benjamin Pisano on 26/01/2018.
//  Copyright © 2018 Snopia. All rights reserved.
//

import UIKit
import MapKit

class ListTableViewController: UITableViewController {

    let list = [Place(coordinate: CLLocationCoordinate2D(latitude: 44.339232, longitude: 1.207528), title: "Montcuq", description: "A cool place to be"),
                Place(coordinate: CLLocationCoordinate2D(latitude: 48.067620, longitude: 12.862121), title: "Fucking", description: "Another cool place")]
    var touchedPlace: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let place = list[indexPath.row]
        
        cell.textLabel?.text = place.title
        cell.detailTextLabel?.text = place.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        touchedPlace = list[indexPath.row]
        performSegue(withIdentifier: "location", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "location" {
            let mapVC = segue.destination as! MapViewController
            
            mapVC.place = touchedPlace
        }
    }
}
