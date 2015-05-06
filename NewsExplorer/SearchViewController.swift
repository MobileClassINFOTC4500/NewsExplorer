//
//  SearchViewController.swift
//  NewsExplorer
//
//  Created by Evan Gibler on 5/5/15.
//  Copyright (c) 2015 Tim Gilman. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let locations = ["Columbia", "St. Louis", "Kansas City", "Springfield", "Nashville"]
    
    let locationManager = CLLocationManager()
    
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = locations[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println(locations[row])
    }
    
    func setLocation(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        if contains(locations, "Columbia") {
            var latitude: CLLocationDegrees = 38.9514
            var longitude:CLLocationDegrees = -92.3283
        }
        else if contains(locations, "St. Louis") {
            var latitude: CLLocationDegrees = 38.6272
            var longitude:CLLocationDegrees = -90.1978
        }
        else if contains(locations, "Kansas City") {
            var latitude: CLLocationDegrees = 39.0997
            var longitude:CLLocationDegrees = -94.5783
        }
        else if contains(locations, "Springfield") {
            var latitude: CLLocationDegrees = 37.1950
            var longitude:CLLocationDegrees = -93.2861
        }
        else if contains(locations, "Nashville") {
            var latitude: CLLocationDegrees = 36.1667
            var longitude:CLLocationDegrees = -86.7833
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
