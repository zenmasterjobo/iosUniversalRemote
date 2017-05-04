//
//  ButtonViewController.swift
//  UniversalRemote
//
//  Created by Lisa Churchman on 4/30/17.
//  Copyright © 2017 CCB. All rights reserved.
//




import UIKit

class ButtonViewController: UIViewController {

    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var irTextField: UITextField!
    
    var deviceName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func irButtonTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let button = Button(context: context)
        button.ir_code = irTextField.text!
        button.device_id = Int32 (deviceTextField.text!)!
        // Save the data to coredata
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let _ = navigationController?.popViewController(animated: true)
    }

    func deviceForThisView(_ device: String) {
        //let device = device.artistName()!
        //artistID = artist.artistID()!
        //print ("\(name), \(artistID!)")
        print ("DEVICE FOR THIS VIEW: \(deviceName!)")
        self.deviceName = device
    }
    
        
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//import UIKit
//
//class AddTaskViewController: UIViewController {
//    
//    @IBOutlet weak var taskTextField: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    @IBAction func buttonTapped(_ sender: UIButton) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        
//        let task = Task(context: context)
//        task.name = taskTextField.text!
//        // Save the data to coredata
//        
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//        let _ = navigationController?.popViewController(animated: true)
//    }
//    
//}
