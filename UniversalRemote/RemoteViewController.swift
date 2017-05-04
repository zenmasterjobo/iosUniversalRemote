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
    var simpleBluetoothIO: SimpleBluetoothIO!
    var deviceName: String?
    var buttons: [Button] = []
    var allbuttons: [Button] = []

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        print (deviceName!)
        print (buttons.count)
        title = deviceName!
        
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self as? SimpleBluetoothIODelegate)
        // Do any additional setup after loading the view.
       // simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self as? SimpleBluetoothIODelegate)
        displayRemote()
        
        
    }
    
    private func displayRemote() {
        let x: Double = 100
        var y: Double = 150
        let w: Double = 50
        for ugh in buttons{
            let b = createButton(x: x, y: y, widthHeight: w)
            b.setTitle(ugh.button_type,for: .normal)
            b.tag = Int (ugh.ir_code!)!
            view.addSubview(b)
            y = y + 70

        }
        
    }
    // Displays alert (Code taken directly from stack overflow to display and alert)
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        //let temp = sender.tag
        var code: UInt32 = 0
        var length: UInt32 = 0
        var b: [Button] = []
        do {
            b = try context.fetch(Button.fetchRequestButtonWithIRCode("\(sender.tag)"))
            code =   UInt32(Int32(Int32(b[0].code_type)))
            length = UInt32(Int32(Int32(b[0].bit_length)))
        }
        catch {
            print("Fetching Failed")
        }
        simpleBluetoothIO.writeValue(value: UInt32(Int32(sender.tag)), something: code, something: length)
        alert(message: "This needs to actually be sending ir code \(sender.tag) via blue tooth", title: "❗️❗️❗️")
    }
   
    func deviceForThisView(_ device: String) {
        //let device = device.artistName()!
        //artistID = artist.artistID()!
        //print ("\(name), \(artistID!)")
        print ("DEVICE FOR THIS VIEW: \(device)")
        self.deviceName = device
    }

    func getData() {
        do {
            buttons = try context.fetch(Button.fetchRequestForDevice("\(deviceName!)"))//fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    func getAllButtonsData() {
        do {
            allbuttons = try context.fetch(Button.fetchRequest())//fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    
    // Creates a button for the cover of a number or mine tile
    private func createButton(x: Double, y: Double, widthHeight: Double) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: x, y: y, width: 200, height: widthHeight)
        button.backgroundColor = UIColor.white
        //let acolor = UIColor.blue
        button.layer.borderColor = UIColor.blue.cgColor;
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        return button
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
