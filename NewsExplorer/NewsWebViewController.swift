//
//  NewsWebViewController.swift
//  NewsExplorer
//
//  Created by Evan Gibler on 5/5/15.
//  Copyright (c) 2015 Tim Gilman. All rights reserved.
//

import UIKit

class NewsWebViewController: UIViewController {

    var webSite: String?
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let address = webSite {
            if let webURL = NSURL(string: address)  {
                let webURL = NSURL(string: address)
                //println(webURL)
                let urlRequest = NSURLRequest(URL: webURL!)
                webView.loadRequest(urlRequest)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
