//
//  WorkCellTableViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/21.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit


class WorkCellTableViewController: UITableViewController {
   
    var cellArrayName = ["Report 1","Report 2","Report 3"]
    var cellDetailArrayName = ["2018/6/12","2018/6/13","2018/6/14"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
   
    
    @IBAction func addNewForm(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Report", message: "Enter report name", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Name"
        })
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            //Date format for new entry
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            //Append data to array
            //cellArrayName.append("Report")
            let name = (alert.textFields?.first?.text)!
            self.cellArrayName.append(name)
            self.cellDetailArrayName.append("\(dateString)")
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.cellArrayName.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cellArrayName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)
        cell.textLabel?.text = cellArrayName[indexPath.row]
        cell.detailTextLabel?.text = cellDetailArrayName[indexPath.row]

        return cell
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}