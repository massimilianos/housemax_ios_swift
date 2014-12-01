//
//  ViewController.swift
//  HouseMax
//
//  Created by Massimiliano on 22/11/14.
//  Copyright (c) 2014 Massimiliano. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var lblTemperatura: UILabel!
    @IBOutlet weak var indicatorUpdateTemperature: UIActivityIndicatorView!

    @IBOutlet weak var lblUmidita: UILabel!
    @IBOutlet weak var indicatorUpdateHumidity: UIActivityIndicatorView!

    @IBOutlet weak var btnUpdateDHT11: UIButton!
    
    @IBOutlet weak var imgModalita: UIButton!
    
    @IBOutlet weak var txtTempControllo: UITextField!
    @IBOutlet weak var lblTempControllo: UILabel!
    @IBOutlet weak var indicatorTempControllo: UIActivityIndicatorView!
    @IBOutlet weak var btnSetTempControllo: UIButton!
    
    @IBOutlet weak var swcManualControl: UISwitch!
    
    @IBOutlet weak var swcRelay1: UISwitch!
    @IBOutlet weak var swcRelay2: UISwitch!
    @IBOutlet weak var swcRelay3: UISwitch!
    @IBOutlet weak var swcRelay4: UISwitch!
    
    let arduinoAddress = "massimilianos.ns0.it"
    let arduinoPort = "82"
    
    func HTTPsendRequest(request: NSMutableURLRequest,
        callback: (String, String?) -> Void) {
            let task = NSURLSession.sharedSession()
                .dataTaskWithRequest(request) {
                    (data, response, error) -> Void in
                    if (error != nil) {
                        callback("", error.localizedDescription)
                    } else {
                        callback(NSString(data: data, encoding: NSUTF8StringEncoding)!, nil)
                    }
            }
            
            task.resume()
    }
    
    func HTTPGet(url: String, callback: (String, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        HTTPsendRequest(request, callback)
    }
    
    func impostaModalita(modalita: NSString){
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?SetModalita="
        
        if (modalita == "0") {
            self.imgModalita.setImage(UIImage(named:"Winter"),forState:UIControlState.Normal)
            self.lblTempControllo.text = "Min."
        } else {
            self.imgModalita.setImage(UIImage(named:"Summer"),forState:UIControlState.Normal)
            self.lblTempControllo.text = "Max."
        }
        
        URL = URL + modalita
        
        HTTPGet(URL) {
            (data: String, error: String?) -> Void in
        }
    }

    @IBAction func pushUpdateDHT11(sender: AnyObject) {
        self.lblTemperatura.hidden = true
        self.indicatorUpdateTemperature.hidden = false
        self.indicatorUpdateTemperature.startAnimating()
        HTTPGet("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?TemperatureRead") {
            (data: String, error: String?) -> Void in
            self.indicatorUpdateTemperature.stopAnimating()
            self.indicatorUpdateTemperature.hidden = true
            self.lblTemperatura.hidden = false
            if (error != nil) {
                self.lblTemperatura.text = "ERR"
            } else {
                self.lblTemperatura.text = data + "°"
            }
        }
        
        self.lblUmidita.hidden = true
        self.indicatorUpdateHumidity.hidden = false
        self.indicatorUpdateHumidity.startAnimating()
        HTTPGet("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?HumidityRead") {
            (data: String, error: String?) -> Void in
            self.lblUmidita.hidden = false
            self.indicatorUpdateHumidity.stopAnimating()
            self.indicatorUpdateHumidity.hidden = true
            if (error != nil) {
                self.lblUmidita.text = "ERR"
            } else {
                self.lblUmidita.text = data + "%"
            }
        }
    }
    
    @IBAction func swcManualControlOnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ManualControl="
        
        if (self.swcManualControl.on) {
            self.swcRelay1.enabled = true;
            self.swcRelay2.enabled = true;
            self.swcRelay3.enabled = true;
            self.swcRelay4.enabled = true;
            
            URL = URL + "ON"
            
            println("ATTIVATO CONTROLLO MANUALE!")
        } else {
            self.swcRelay1.enabled = false;
            self.swcRelay2.enabled = false;
            self.swcRelay3.enabled = false;
            self.swcRelay4.enabled = false;
            
            URL = URL + "OFF"
            
            println("DISATTIVATO CONTROLLO MANUALE!")
        }
        
        HTTPGet(URL) {
            (data: String, error: String?) -> Void in
        }
    }
    
    @IBAction func changeModalita(sender: AnyObject) {
        var modalita = ""
        
        HTTPGet("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadModalita") {
            (data: String, error: String?) -> Void in
            if data == "0" {
                modalita += "1"
            } else {
                modalita += "0"
            }
        }
        
        self.impostaModalita(modalita)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.indicatorUpdateTemperature.hidden = true
        self.indicatorUpdateHumidity.hidden = true
/*
        HTTPGet("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadModalita") {
            (data: String, error: String?) -> Void in
            self.impostaModalita(data.toInt()!)
        }
*/
        self.indicatorTempControllo.hidden = false
        self.indicatorTempControllo.startAnimating()
        
        HTTPGet("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadTempControl") {
            (data: String, error: String?) -> Void in
            if (error != nil) {
                self.txtTempControllo.text = "ERR"
            } else {
                self.txtTempControllo.text = data
            }
            
            self.indicatorTempControllo.stopAnimating()
            self.indicatorTempControllo.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

