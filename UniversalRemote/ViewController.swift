//
//  ViewController.swift
//  UniversalRemote
//
//  Created by Brian Crosser on 4/12/17.
//  Copyright © 2017 CCB. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var simpleBluetoothIO: SimpleBluetoothIO!

    var tasks: [Button] = []
    var devices: [Device] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var deviceTableView: UITableView!

    @IBOutlet weak var receivedCode: UILabel!
    @IBOutlet weak var sendCodeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Remotes"
        deviceTableView.delegate = self
        deviceTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
       // simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self as? SimpleBluetoothIODelegate)
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
        deviceTableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        simpleBluetoothIO.writeValue(codeValue: 691090, typeValue: 2, bitValue: 20)
        
         print("pressed button")

    }
    
    // for adding a new remote and retrieving ir codes from external remote
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: UInt32) {
        receivedCode.text = String(value)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath)
        let device = devices[indexPath.row]
        
        if let deviceName = device.name {
            cell.textLabel?.text = deviceName
        }
        /*
         let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
         
         if let theCell = cell as? ArtistTableViewCell, let artist = artistsDS?.artistAt(indexPath.row) {
         theCell.useArtist(artist)
         }
         
         return cell
 */
        return cell
    }
    
    func getData() {
        do {
            devices = try context.fetch(Device.fetchRequest())//fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = devices[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
//                tasks = try context.fetch(Button.fetchRequest())
                devices = try context.fetch(Device.fetchRequest())

            }
            catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowButtons" {
             if let row = deviceTableView.indexPathForSelectedRow?.row {
             let detailedVC = segue.destination as! RemoteViewController
             detailedVC.deviceForThisView(devices[row].name!)
             }
        }
    }
    
}
