//
//  RemoteViewController.swift
//  UniversalRemote
//
//  Created by Lisa Churchman on 5/1/17.
//  Copyright © 2017 CCB. All rights reserved.
//

import UIKit

class RemoteViewController: UIViewController {

    //@IBOutlet weak var buttonAdd: UIBarButtonItem!
    //var simpleBluetoothIO: SimpleBluetoothIO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self as? SimpleBluetoothIODelegate)
        
        
    }
    // Displays alert (Code taken directly from stack overflow to display and alert)
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        alert(message: "This needs to actually be sending ir code via blue tooth", title: "❗️❗️❗️")
    }
   
    /*
    
    @IBAction func button_tapped(_ sender: UIButton) {
        //simpleBluetoothIO.writeValue(value: 691090)
        let button2Alert: UIAlertView = UIAlertView(title: "Title", message: "message",
                                                    delegate: self as! UIAlertViewDelegate, cancelButtonTitle: "Ok")
        button2Alert.show()
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
