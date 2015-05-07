//
//  NewsViewController.swift
//  NewsExplorer
//
//  Created by Tim Gilman on 4/30/15.
//  Copyright (c) 2015 Tim Gilman. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class NewsViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate {

    var newSites: NewSite = NewSite()
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var link = NSMutableString()
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var radiusSlider: UISlider!
    
    var radiusStr:String?
    
    var url:String?
    
    let locationManager = CLLocationManager()
    
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    
    
    @IBOutlet weak var articleTableView: UITableView!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //var currentLocation = locationManager.location
        
        var radiusVal = radiusSlider.value
        radiusStr = NSString(format: "%f", radiusVal)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function used to parse Url to get all xml url's
    func ParseUrl(stringUrl: String, completionHandler: () -> Void)
    {
        println("load url")
        newSites.load(stringUrl) {
        (newsites, errorString) -> Void in
        if "" == errorString {
            completionHandler()
            
        } else {
            println("error")
            
            //self.newsTableView.reloadData()
        }
            println("after loaded")
            println("count: \(self.newSites.sites.count)")
        
            for item in self.newSites.sites
            {
                println(item)
                var url = NSURL(string: item)
                self.beginParsing(url!)
            }
        }
        // can do something about error here
        

       
        

    }
    
    
    //update location when location changes
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Error:" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.navBar.topItem?.title = self.displayLocationTitle(pm)
                if(self.latitude != self.locationManager.location.coordinate.latitude || self.longitude != self.locationManager.location.coordinate.longitude)
                {
                    self.latitude = self.locationManager.location.coordinate.latitude
                    println("latitude: \(self.latitude)")
                    self.longitude = self.locationManager.location.coordinate.longitude
                    println("longitude: \(self.longitude)")
                    self.url = "http://babbage.cs.missouri.edu/~tlw44f/index.php/apiServer/sources/?latitude=\(self.latitude!)&longitude=\(self.longitude!)&radius=\(self.radiusStr!).json"
                    
                    //self.url = "http://babbage.cs.missouri.edu/~tlw44f/index.php/apiServer/sources/?latitude=39.248207&longitude=-92.129974&radius=100.json"
                    
                    println(self.url!)
                    self.ParseUrl(self.url!)
                        { () -> Void in }
                }
                

            } else {
                println("Error with data")
            }
        })

    }
    
    func displayLocationTitle(placemark: CLPlacemark) -> String {
        return placemark.locality + ", " + placemark.administrativeArea
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeNewsCell", forIndexPath: indexPath) as UITableViewCell

        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as NSString
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("date") as NSString
        
        return cell as UITableViewCell
        
    }


    @IBAction func showRadius(sender: AnyObject) {
        var currentValue = radiusSlider.value
        sliderLabel.text = String(format: "%.0f", currentValue) + " miles"
    }
    
    //being parsing xml url
    func beginParsing(url: NSURL)
    {
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.parse()
        while posts.count > 20
        {
            posts.removeLastObject()
        }
        articleTableView.reloadData()
    }
    
    //actually parse xml
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!)
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            title1 = NSMutableString.alloc()
            title1 = ""
            date = NSMutableString.alloc()
            date = ""
            link = NSMutableString.alloc()
            link = ""
            
        }
    }
    
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if element.isEqualToString("title") {
            title1.appendString(string)
        } else if element.isEqualToString("pubDate") {
            date.appendString(string)
        } else if element.isEqualToString("link") {
            link.appendString(string)
        }
    }
    
    //parser for specific elements
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date")
            }
            
            posts.addObject(elements)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if segue.identifier == "showWebView" {
                let detailViewController = segue.destinationViewController as NewsWebViewController
                detailViewController.self.navBar.topItem?.title = title
                //detailViewController.webSite = (string: link)
            } else if segue.identifier == "showSearchView" {
                let detailViewController = segue.destinationViewController as SearchViewController
            }
        }
}
