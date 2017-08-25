//
//  ViewController.swift
//  AddMultipleButtonOnSlideCell
//
//  Created by Appinventiv Technologies on 25/08/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
// ========== variable's =====================
    var rowArray = ["1","2","3","4","5","6","7","8","9","10"]
    var stName = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"]
//=========== Outlet's =======================
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}
//=========== Class extension ================
extension ViewController: UITableViewDataSource,UITableViewDelegate{
//------------- For number of rows-------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//============ methode for TableView ----------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellDataClass", for: indexPath) as? CellDataClass else{
            fatalError()
        }
        cell.cellDataLabel.text = rowArray[indexPath.row]
        return cell
    }
//---------------- For add multiple action's---------------
     func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
           print("Delete button tapped")
            self.rowArray.remove(at: editActionsForRowAt.row)
            tableView.deleteRows(at: [editActionsForRowAt], with: UITableViewRowAnimation.automatic)
            print(self.rowArray)
        }
        deleteButton.backgroundColor = .red
        let nameData = UITableViewRowAction(style: .normal, title: "Name") { action, index in
        print("Name button tapped")
            let cell = self.tableView.cellForRow(at: editActionsForRowAt) as! CellDataClass
            cell.cellDataLabel.text = self.stName[editActionsForRowAt.row]
        }
        nameData.backgroundColor = .orange
        return [deleteButton,nameData]
    }
    

}

//--------------- method for creating cell -------------
func getCell(_ label: UILabel) -> UITableViewCell{
    var cell : UIView = label
    while !(cell is CellDataClass) {
        if let super_view = cell.superview {
            cell = super_view
        }else{}
    }
    guard let tableCell = cell as? CellDataClass else {fatalError()}
    return tableCell
}

//============ Class for cell ================
class CellDataClass: UITableViewCell {
    @IBOutlet weak var cellDataLabel: UILabel!
    
}

