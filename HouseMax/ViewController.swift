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
        
        let internetURL = NSURL(string:"http://massimilianos.ns0.it:82/temperatureRead/0/0")
        
        let sensorURL = NSURLRequest(URL: internetURL!)
        let sensorData = NSURLConnection(request: sensorURL, delegate: nil, startImmediately: true)
        let strSensorData = NSString(data: sensorData, encoding: NSUTF8StringEncoding)
        
        self.lblTemperatura.text = strSensorData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}

