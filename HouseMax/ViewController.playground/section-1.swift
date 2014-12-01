// Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground

// This will allow you to use asynchronous code in playgrounds.
XCPSetExecutionShouldContinueIndefinitely()
/*
let url = NSURL(string: "http://massimilianos.ns0.it")
let request = NSURLRequest(URL: url!)
NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
    println(NSString(data: data, encoding: NSUTF8StringEncoding))
}
let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)

let url = NSURL(string: "http://www.stackoverflow.com")

let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
    println(NSString(data: data, encoding: NSUTF8StringEncoding))
}

task.resume()
*/