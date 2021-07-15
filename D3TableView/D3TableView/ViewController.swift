//
//  ViewController.swift
//  D3TableView
//
//  Created by Nabeel Ahamed on 7/14/21.
//

import UIKit

class ViewController: UIViewController {
    
    var bayArea = ["San Francisco", "San Jose", "Mountain View", "Palo Alto", "Dublin"]
    var eastCoast = ["New York", "New Jersey", "Boston", "Buffalo", "Baltimore"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Manually configured refresh controller
        if tableView.refreshControl == nil {
            refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(ViewController.refreshTable), for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
        
        // Write & read data from local
        let str = "Hello world!"
        let path = NSTemporaryDirectory() + "test.txt"
        writeString(str: str, path: path)
        let str2 = readString(path: path)
        print (str2)
    }

    @objc func refreshTable() {
        bayArea.append("New City")
        eastCoast.append("New City")
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segCellInfo" || segue.identifier == "segCellInfo2" {
            
            guard let vc = segue.destination as? SecondViewController else { return }
            vc.text = "Prepared!"
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let textValue = segue.identifier == "segCellInfo" ? bayArea[indexPath.row] : eastCoast[indexPath.row]
            vc.text = textValue
        }
    }
    
    func writeString (str: String, path: String) {
        let urlPath = URL(fileURLWithPath: path)
        let data = str.data(using: .utf8)
        try? data?.write(to: urlPath)
    }
    
    func readString (path: String) -> String {
        let urlPath = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: urlPath) else { return "" }
        let str = String(data: data, encoding: .utf8) ?? ""
        return str
    }

}

extension ViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? bayArea.count : eastCoast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cellIdentifier = indexPath.section == 0 ? "cellInfo" : "cellInfo1"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(bayArea[indexPath.item])"
            cell.detailTextLabel?.text = "\(Date())"
        } else {
            cell.textLabel?.text = "\(eastCoast[indexPath.item])"
            cell.detailTextLabel?.text = "\(Date())"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Section style: Right detail" : "Section style: Subtitle"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "Delete"
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .delete:
//            if indexPath.section == 0 {
//                bayArea.remove(at: indexPath.row)
//            } else {
//                eastCoast.remove(at: indexPath.row)
//            }
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        default:
//            print ("edit style - switch in default")
//        }
//    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSave = UIContextualAction(style: .normal, title: "Save"){ action, view, handler in
            print ("Saving...")
            handler(true)
        }
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete"){ action, view, handler in
            print ("Deleting...")
            if indexPath.section == 0 {
                self.bayArea.remove(at: indexPath.row)
            } else {
                self.eastCoast.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        let config = UISwipeActionsConfiguration.init(actions: [actionDelete, actionSave])
        return config
    }
    
}
