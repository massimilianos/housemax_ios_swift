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
        var errore: NSErrorPointer = nil
        
        let internetURL = NSURL(string: URL)
        var datastring = NSString(contentsOfURL: internetURL!, usedEncoding: nil, error: errore)
        
        return(datastring)!
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
        
        print("impostaModalita URL: '")
        print(URL)
        println("'")
        
        var data = inviaRichiestaHTTP(URL)
    }

    @IBAction func pushUpdateDHT11Temperature(sender: AnyObject) {
        // LEGGO IL VALORE DELLA TEMPERATURA
        self.lblTemperatura.hidden = true
        self.indicatorUpdateTemperature.hidden = false
        self.indicatorUpdateTemperature.startAnimating()
        
        var dataTemperatureRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?TemperatureRead")
        
        print("pushUpdateDHT11 TemperatureRead: '")
        print(dataTemperatureRead)
        println("'")
        
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
        
        var dataHumidityRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?HumidityRead")
        
        print("pushUpdateDHT11 HumidityRead: '")
        print(dataHumidityRead)
        println("'")
        
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
            
            println("ATTIVATO CONTROLLO MANUALE!")
        } else {
            self.swcRelay1.enabled = false;
            self.swcRelay2.enabled = false;
            self.swcRelay3.enabled = false;
            self.swcRelay4.enabled = false;
            
            URL = URL + "OFF"
            
            println("DISATTIVATO CONTROLLO MANUALE!")
        }
        
        var data = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay1OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay1="
        
        if (self.swcRelay1.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay1OnOff URL: '")
        print(URL)
        println("'")
        
        var data = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay2OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay2="
        
        if (self.swcRelay2.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay2OnOff URL: '")
        print(URL)
        println("'")
        
        var data = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay3OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay3="
        
        if (self.swcRelay3.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay3OnOff URL: '")
        print(URL)
        println("'")
        
        var data = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func swcRelay4OnOff(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?Relay4="
        
        if (self.swcRelay4.on) {
            URL = URL + "ON"
        } else {
            URL = URL + "OFF"
        }
        
        print("swcRelay4OnOff URL: '")
        print(URL)
        println("'")
        
        var data = inviaRichiestaHTTP(URL)
    }
    
    @IBAction func changeModalita(sender: AnyObject) {
        var data = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadModalita")
        
        print("changeModalita: '")
        print(data)
        println("'")
        
        if data == "0" {
            self.impostaModalita("1")
        } else {
            self.impostaModalita("0")
        }
    }
    
    @IBAction func pushSetTempControllo(sender: AnyObject) {
        var URL = "http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?SetTempControl="
        
        URL = URL + self.txtTempControllo.text
        
        print("pushSetTempControllo URL: '")
        print(URL)
        println("'")
        
        var data = inviaRichiestaHTTP(URL)
        
        // LEGGO IL VALORE DELLA TEMPERATURA
        var dataTemperatureRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?TemperatureRead")
        
        print("pushSetTempControllo TemperatureRead: '")
        print(dataTemperatureRead)
        println("'")
        
        self.lblTemperatura.text = dataTemperatureRead + "°"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.indicatorUpdateTemperature.hidden = true
        self.indicatorUpdateHumidity.hidden = true

        // LEGGO IL VALORE DELLA MODALITA' STAGIONALE (INVERNO/ESTATE) ATTIVA
        var dataReadModalita = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadModalita")
        
        print("viewDidLoad ReadModalita: '")
        print(dataReadModalita)
        println("'")
        
        self.impostaModalita(dataReadModalita)
        
        // LEGGO IL VALORE DELLA MODALITA' DI CONTROLLO ATTIVA
        self.indicatorTempControllo.hidden = false
        self.indicatorTempControllo.startAnimating()

        var dataTempControllo = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?ReadTempControl")
        
        print("viewDidLoad TempControllo: '")
        print(dataTempControllo)
        println("'")
        
        self.txtTempControllo.text = dataTempControllo
        
        self.indicatorTempControllo.stopAnimating()
        self.indicatorTempControllo.hidden = true
        
        // LEGGO IL VALORE DELLA TEMPERATURA
        self.lblTemperatura.hidden = true
        self.indicatorUpdateTemperature.hidden = false
        self.indicatorUpdateTemperature.startAnimating()
        
        var dataTemperatureRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?TemperatureRead")
        
        print("pushUpdateDHT11 TemperatureRead: '")
        print(dataTemperatureRead)
        println("'")
        
        self.indicatorUpdateTemperature.stopAnimating()
        self.indicatorUpdateTemperature.hidden = true
        self.lblTemperatura.hidden = false
        
        self.lblTemperatura.text = dataTemperatureRead + "°"
        
        // LEGGO IL VALORE DELL'UMIDITA'
        self.lblUmidita.hidden = true
        self.indicatorUpdateHumidity.hidden = false
        self.indicatorUpdateHumidity.startAnimating()
        
        var dataHumidityRead = inviaRichiestaHTTP("http://" + arduinoAddress + ":" + arduinoPort + "/index.htm?HumidityRead")
        
        print("pushUpdateDHT11 HumidityRead: '")
        print(dataHumidityRead)
        println("'")
        
        self.lblUmidita.hidden = false
        self.indicatorUpdateHumidity.stopAnimating()
        self.indicatorUpdateHumidity.hidden = true
        
        self.lblUmidita.text = dataHumidityRead + "%"
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

