//
//  ViewController.swift
//  HouseMax
//
//  Created by Massimiliano on 22/11/14.
//  Copyright (c) 2014 Massimiliano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTemperatura: UILabel!
    @IBOutlet weak var lblUmidita: UILabel!
    
    @IBOutlet weak var btnUpdateDHT11: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var strData = "";
        
        let url = NSURL(string: "http://massimilianos.ns0.it:82/temperatureRead/0/0")
        
        let session = NSURLSession.sharedSession()
            
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response:NSURLResponse!,
            error: NSError!) -> Void in
            
            strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
        })
        
        self.lblTemperatura.text = strData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}

