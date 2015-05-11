//
//  HistoryViewController.swift
//  NewsExplorer
//
//  Created by Evan Gibler on 5/8/15.
//  Copyright (c) 2015 Tim Gilman. All rights reserved.
//

import UIKit
import Foundation

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let locations = ["Columbia, MO", "Springfield, MO", "Nashville, TN"]
    
    let articles = [3, 7, 10]

    var selectedCity: String?
    var numArticles = 0
    
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
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
        cell.detailTextLabel?.text = "\(articles[indexPath.row])" + " articles"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selectedCity = locations[indexPath.row]
        numArticles = articles[indexPath.row]
        performSegueWithIdentifier("showHistoryArticles", sender: self)
        println(locations[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHistoryArticles" {
            let detailViewController = segue.destinationViewController as HistoryArticlesViewController
            //detailViewcontroller.city = selectedCity
            detailViewController.numArticles = numArticles
            if let theName = selectedCity
            {
                detailViewController.self.city = theName
            }
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
