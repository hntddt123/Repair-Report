//
//  WorkCellTableViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/21.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit
import CoreData

class WorkCellTableViewController: UITableViewController {
   
    //Cellarray contains "Report x"
    //Cellarray date contains "2018/06/12 for right detail"
    var reports: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
   
    @IBAction func addNewForm(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Report", message: "Enter report name", preferredStyle: .alert)
        
        //Textbox decoration
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Name"
        })
        //Cancel Action
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: " Default action"), style: .cancel , handler: { _ in
        }))
        //OK Action
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
            //Date format for new entry
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            //Append data to NSManagedObject array
            let titleToSave = (alert.textFields?.first?.text)!
            self.save(with: titleToSave, with: dateString)
            
            //Update Table
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.reports.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func save(with title: String, with date: String) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }

        //NSObject context
        let managedContext = appDelegate.persistentContainer.viewContext
        //Insert to NSManagedObject
        let entity = NSEntityDescription.entity(forEntityName: "Report",
                                                in: managedContext)!
        let report = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        //key-value coding
        report.setValue(title, forKeyPath: "reportTitle")
        report.setValue(date, forKeyPath: "fillDate")

        //save
        do {
            try managedContext.save()
            reports.append(report)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Not Repaired"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)
        let report = reports[indexPath.row]
        cell.textLabel?.text = report.value(forKeyPath: "reportTitle") as? String
        cell.detailTextLabel?.text = report.value(forKeyPath: "fillDate") as? String

        return cell
    }
    
//    private func updateDatabase(with report: [String]) {
//        container?.performBackgroundTask({ (context) in
//            for name in self.cellArrayName {
//                //add name
//                let request = NSFetchRequest<NSManagedObject>(entityName: "title")
//
//            }
//        })
//    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
