//
//  ViewController.swift
//  PlainLogger
//
//  Created by Burak Akkaş on 01/31/2019.
//  Copyright (c) 2019 Burak Akkaş. All rights reserved.
//

import UIKit
import PlainLogger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Log
        PlainLogger.debug(message: "Test debug")
        PlainLogger.error(message: "Test error")
        PlainLogger.info(message: "Test info")
        PlainLogger.verbose(message: "Test verbose")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

