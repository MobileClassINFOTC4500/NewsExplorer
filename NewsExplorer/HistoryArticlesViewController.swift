//
//  HistoryArticlesViewController.swift
//  NewsExplorer
//
//  Created by Evan Gibler on 5/11/15.
//  Copyright (c) 2015 Tim Gilman. All rights reserved.
//

import UIKit
import Foundation

class HistoryArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var city: String?
    var numArticles: Int?
    
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
   
    var articleTitle = ["Article 1", "Article 2", "Article 3", "Article 4", "Article 5", "Article 6", "Article 7", "Article 8", "Article 9", "Article 10"]
    var url = ["http://www.google.com", "http://www.yahoo.com", "http://www.weather.com", "http://www.reddit.com", "http://www.apple.com", "http://www.twitter.com", "http://www.facebook.com", "http://www.wikipedia.org", "http://www.http://www.columbiamissourian.com/", "http://www.columbiatribune.com/"]
    var address: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        
        self.navBar.topItem?.title = city
        
        if city == "Columbia, MO" {
            numArticles = 3
        }
        else if city == "Springfield, MO" {
            numArticles = 7
        }
        else if city == "Nashville, TN" {
            numArticles = 10
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numArticles!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = articleTitle[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        address = url[indexPath.row]
        performSegueWithIdentifier("showHistoryWebView", sender: self)
        //println articleTitle[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showHistoryWebView" {
            let detailViewController = segue.destinationViewController as NewsWebViewController
            detailViewController.webSite = (string: address)
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
