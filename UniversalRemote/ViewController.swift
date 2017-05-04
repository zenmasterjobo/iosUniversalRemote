//
//  ViewController.swift
//  UniversalRemote
//
//  Created by Brian Crosser on 4/12/17.
//  Copyright © 2017 CCB. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    var simpleBluetoothIO: SimpleBluetoothIO!
    
    @IBOutlet weak var receivedCode: UILabel!
    @IBOutlet weak var sendCodeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self as? SimpleBluetoothIODelegate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        simpleBluetoothIO.writeValue(codeValue: 691090, typeValue: 2, bitValue: 20)
        
    }
    
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: UInt32) {
        receivedCode.text = String(value)
    }
    
}
