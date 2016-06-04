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
    
    func inviaRichiestaHTTP(URL: String) -> String {
        let errore: NSErrorPointer = nil
        
        let internetURL = NSURL(string: URL)
        var datastring: NSString?
        do {
            datastring = try NSString(contentsOfURL: internetURL!, usedEncoding: nil)
        } catch let error as NSError {
            errore.memory = error
            datastring = nil
        }
        
        return(datastring)! as String
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
        
        URL = URL + (modalita as String)
        
        print("impostaModalita URL: '", terminator: "")
        print(URL, terminator: "")
        print("'")
        
        _ = inviaRichiestaHTTP(URL)
    }

    @IBAction func pushUpdateDHT11Temperature(sender: AnyObject) {
        // LEGGO IL VALORE DELLA TEMPERATURA
        self.lblTemperatura.hidden = true
        self.indicatorUpdateTemperature.hidden = false
        self.indicatorUpdateTemperature.startAnimating()
        
        let dataTemperatureRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?TemperatureRead")
        
        print("pushUpdateDHT11 TemperatureRead: '", terminator: "")
        print(dataTemperatureRead, terminator: "")
        print("'")
        
        self.indicatorUpdateTemperature.stopAnimating()
        self.indicatorUpdateTemperature.hidden = true
        self.lblTemperatura.hidden = false
        
        self.lblTemperatura.text = dataTemperatureRead + "°"
    }
    
    @IBAction func pushUpdateDHT11Humidity(sender: AnyObject) {
        // LEGGO IL VALORE DELL'UMIDITA'
        self.lblUmidita.hidden = true
        self.indicatorUpdateHumidity.hidden = false
        self.indicatorUpdateHumidity.startAnimating()
        
        let dataHumidityRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?HumidityRead")
        
        print("pushUpdateDHT11 HumidityRead: '", terminator: "")
        print(dataHumidityRead, terminator: "")
        print("'")
        
        self.lblUmidita.hidden = false
        self.indicatorUpdateHumidity.stopAnimating()
        self.indicatorUpdateHumidity.hidden = true
        
        self.lblUmidita.text = dataHumidityRead + "%"
    }
    
    @IBAction func swcManualControlOnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ManualControl="
        
        if (self.swcManualControl.on) {
            self.swcRelay1.enabled = true;
            self.swcRelay2.enabled = true;
            self.swcRelay3.enabled = true;
            self.swcRelay4.enabled = true;
            
            URL = URL + "ON"
            
            print("ATTIVATO CONTROLLO MANUALE!")
        } else {
            self.swcRelay1.enabled = false;
            self.swcRelay2.enabled = false;
            self.swcRelay3.enabled = false;
            self.swcRelay4.enabled = false;
            
            URL = URL + "OFF"
            
            print("DISATTIVATO CONTROLLO MANUALE!")
        }
        
        _ = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay1OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay1="
        
        if (self.swcRelay1.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay1OnOff URL: '", terminator: "")
        print(URL, terminator: "")
        print("'")
        
        _ = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay2OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay2="
        
        if (self.swcRelay2.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay2OnOff URL: '", terminator: "")
        print(URL, terminator: "")
        print("'")
        
        _ = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay3OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay3="
        
        if (self.swcRelay3.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay3OnOff URL: '", terminator: "")
        print(URL, terminator: "")
        print("'")
        
        _ = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay4OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay4="
        
        if (self.swcRelay4.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay4OnOff URL: '", terminator: "")
        print(URL, terminator: "")
        print("'")
        
        _ = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func changeModalita(sender: AnyObject) {
        let data = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadModalita")
        
        print("changeModalita: '", terminator: "")
        print(data, terminator: "")
        print("'")
        
        if data == "0" {
            self.impostaModalita("1")
        } else {
            self.impostaModalita("0")
        }
    }
    
    @IBAction func pushSetTempControllo(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?SetTempControl="
        
        URL = URL + self.txtTempControllo.text!
        
        print("pushSetTempControllo URL: '", terminator: "")
        print(URL, terminator: "")
        print("'")
        
        _ = inviaRichiestaHTTP(URL)
        
        // LEGGO IL VALORE DELLA TEMPERATURA
        let dataTemperatureRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?TemperatureRead")
        
        print("pushSetTempControllo TemperatureRead: '", terminator: "")
        print(dataTemperatureRead, terminator: "")
        print("'")
        
        self.lblTemperatura.text = dataTemperatureRead + "°"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.indicatorUpdateTemperature.hidden = true
        self.indicatorUpdateHumidity.hidden = true

        // LEGGO IL VALORE DELLA MODALITA' STAGIONALE (INVERNO/ESTATE) ATTIVA
        let dataReadModalita = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadModalita")
        
        print("viewDidLoad ReadModalita: '", terminator: "")
        print(dataReadModalita, terminator: "")
        print("'")
        
        self.impostaModalita(dataReadModalita)
        
        // LEGGO IL VALORE DELLA MODALITA' DI CONTROLLO ATTIVA
        self.indicatorTempControllo.hidden = false
        self.indicatorTempControllo.startAnimating()

        let dataTempControllo = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadTempControl")
        
        print("viewDidLoad TempControllo: '", terminator: "")
        print(dataTempControllo, terminator: "")
        print("'")
        
        self.txtTempControllo.text = dataTempControllo
        
        self.indicatorTempControllo.stopAnimating()
        self.indicatorTempControllo.hidden = true
        
        // LEGGO IL VALORE DELLA TEMPERATURA AD INTERVALLI REGOLARI
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "pushUpdateDHT11Temperature:", userInfo: nil, repeats: true)
        // LEGGO IL VALORE DELL'UMIDITA' AD INTERVALLI REGOLARI
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "pushUpdateDHT11Humidity:", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }

}

