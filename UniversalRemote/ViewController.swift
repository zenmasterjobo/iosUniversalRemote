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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var irCodeTableView: UITableView!
    @IBOutlet weak var receivedCode: UILabel!
    @IBOutlet weak var sendCodeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        irCodeTableView.delegate = self
        irCodeTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "19B10010-E8F2-537E-4F6C-D104768A1214", delegate: self as? SimpleBluetoothIODelegate)
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
        irCodeTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        simpleBluetoothIO.writeValue(value: 691090)
        print("pressed button")

    }
    
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: UInt32) {
        receivedCode.text = String(value)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath)
        let button = tasks[indexPath.row]
        
        if let ir_code = button.ir_code {
            cell.textLabel?.text = ir_code
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
            tasks = try context.fetch(Button.fetchRequest())//fetchAllRequest(1))//fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
//                tasks = try context.fetch(Button.fetchRequest())
                tasks = try context.fetch(Button.fetchAllRequest(1))

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
            
            /* if let row = tableView.indexPathForSelectedRow?.row {
             let artist = artistsDS?.artistAt(row)
             let detailedVC = segue.destination as! AlbumTableViewController
             detailedVC.albumForThisView(artist!)
             }*/
            
            // OR
           // let cell = sender as! ArtistTableViewCell
           // if let indexPath = tableView.indexPath(for: cell), let ds = artistsDS {
           //     let detailedVC = segue.destination as! AlbumTableViewController
           //     detailedVC.artistForThisView(ds.artistAt(indexPath.row))
           // }
            
        }
        
        
    }


}

