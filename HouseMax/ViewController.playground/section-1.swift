// Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground

// This will allow you to use asynchronous code in playgrounds.
XCPSetExecutionShouldContinueIndefinitely()

let internetURL = NSURL(string: "http://massimilianos.ns0.it:82/index.htm?TemperatureRead")
var datastring = NSString(contentsOfURL: internetURL!, usedEncoding: nil, error: nil)