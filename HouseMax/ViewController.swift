//
//  ViewController.swift
//  HouseMax
//
//  Created by Massimiliano on 22/11/14.
//  Copyright (c) 2014 Massimiliano. All rights reserved.
//

import UIKit

class CodeViewController: NSObject {
    
    var output : String = "Unable to load data"
    
    init(_output: String) {
        self.output = _output;
    }
    
    func downloadHTML (path: String) -> String {
        var url = NSURL(string: "\(path)")
        var request = NSURLRequest(URL: url!)
        
        let completionBlock: (NSURLResponse!, NSData!, NSError!) -> Void = {response, data, error in
            self.output = NSString(data: data, encoding: NSUTF8StringEncoding)!
            println("Asynch completed \(self.output)")
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: completionBlock)
        
        return output
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var lblTemperatura: UILabel!
    @IBOutlet weak var lblUmidita: UILabel!
    
    @IBOutlet weak var btnUpdateDHT11: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var codeView = CodeViewController(_output: "MASSIMILIANO")
    
        codeView.downloadHTML("http://massimilianos.ns0.it:82/temperatureRead/0/0")
        println("Immediate \(codeView.output)")
    
//        self.lblTemperatura.text = strData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

