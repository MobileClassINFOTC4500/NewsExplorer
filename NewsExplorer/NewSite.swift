//
//  NewSite.swift
//  NewsExplorer
//
//  Created by Tim Gilman on 5/3/15.
//  Copyright (c) 2015 Tim Gilman. All rights reserved.
//

import Foundation

class NewSite{
    var sites = Array<String>()
    
    init()
    {
        sites = ["http://www.bocojo.com/?rss=news","http://www.connectmidmissouri.com/rss.aspx?feed=local_news", "http://www.komu.com/feeds/rssfeed.cfm?category=5&cat_name=News"]
    }
    
    func load(fromURLString: String, completionHandler: (NewSite, String?) -> Void) {
        if let url = NSURL(string: fromURLString) {
            let urlRequest = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
                (data, response, error) -> Void in
                if error != nil {
                    println("Error with from")
                    dispatch_async(dispatch_get_main_queue(), {
                        completionHandler(self, error.localizedDescription)
                    })
                } else {
                    self.parse(data, completionHandler)
                }
            })
            
            task.resume()
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(self, "Invalid URL")
            })
        }
    }
    
    func parse(jsonData: NSData, completionHandler: (NewSite, String?) -> Void) {
        var jsonError: NSError?
    
        if let jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as? NSArray {
            if(jsonResult.count > 0)
            {
                for feed in jsonResult
                {
                    sites.append("\(feed)")
                    println("\(feed)")
                }
            }
        } else {
            if let unwrappedError = jsonError {
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(self, "\(unwrappedError)")
                })
            }
        }
        
    }


}