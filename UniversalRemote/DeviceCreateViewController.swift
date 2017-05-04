//
//  DeviceCreateViewController.swift
//  UniversalRemote
//
//  Created by Lisa Churchman on 5/1/17.
//  Copyright © 2017 CCB. All rights reserved.
//

import UIKit

class DeviceCreateViewController: UIViewController {

    @IBOutlet weak var deviceTypeTextField: UITextField!
    @IBOutlet weak var deviceNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func createDeviceButtonDidTap(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let device = Device(context: context)
        device.name = deviceNameTextField.text!
        device.type = Int16 (deviceTypeTextField.text!)!
        // Save the data to coredata
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        createButtonsForDevice()
        let _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    private func createButtonsForDevice() {
        // type 1: DVD
        if let type = Int16 (deviceTypeTextField.text!), let dname = deviceNameTextField.text{
            if type == 1 {
                createDVDRemote(dname)
            }
        }
        
    }
    
    // All Remotes
    private func createDVDRemote(_ dname: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        //power
        let button = Button(context: context)
        button.button_type = "On/Off"
        button.ir_code = "691090"
        button.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //let _ = navigationController?.popViewController(animated: true)
        
        //open/close
        let button2 = Button(context: context)
        button2.button_type = "Open/Close"
        button2.ir_code = "428946"
        button2.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Play
        let button3 = Button(context: context)
        button3.button_type = "Play"
        button3.ir_code = "314285"
        button3.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //Pause
        let buttonpause = Button(context: context)
        buttonpause.button_type = "Pause"
        buttonpause.ir_code = "641938"
        buttonpause.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //fast forward
        let button4 = Button(context: context)
        button4.button_type = "Fast Forward"
        button4.ir_code = "805778"
        button4.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //rewind
        let button5 = Button(context: context)
        button5.button_type = "Rewind"
        button5.ir_code = "281490"
        button5.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //skip
        let button6 = Button(context: context)
        button6.button_type = "Skip"
        button6.ir_code = "805778"
        button6.device_name = dname
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
