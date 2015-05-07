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
    
    var locationReturn:CLLocation?
    
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
    
    func setLocation([String]) -> (CLLocation) {
        
        if contains(locations, "Columbia") {
            locationReturn = CLLocation(latitude: 38.9514, longitude: -92.3283)
        }
        else if contains(locations, "St. Louis") {
            locationReturn = CLLocation(latitude: 38.6272, longitude: -90.1978)
        }
        else if contains(locations, "Kansas City") {
            locationReturn = CLLocation(latitude: 39.0997, longitude: -94.5783)
        }
        else if contains(locations, "Springfield") {
            locationReturn = CLLocation(latitude: 37.1950, longitude: -93.2861)
        }
        else if contains(locations, "Nashville") {
            locationReturn = CLLocation(latitude: 36.1667, longitude: -86.7833)
        }
        return locationReturn!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if segue.identifier == "changeLocation" {
                let detailViewController = segue.destinationViewController as NewsViewController
                detailViewController.self.segueLocation = setLocation(locations)
                detailViewController.self.status = 1
                //detailViewController.longitude = setLongitude(longitude)
                //detailViewController.navBar.topItem?.title = locations[]
            }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
