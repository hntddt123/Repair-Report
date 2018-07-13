//
//  WorkCellTableViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/21.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit
import CoreData

class WorkCellTableViewController: UITableViewController, UITextFieldDelegate {
   
    //Cellarray contains "Report x"
    //Cellarray date contains "2018/06/12 for right detail"
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
    var searchText: String? {
        didSet {
            searchTextField?.text = searchText
            searchTextField?.resignFirstResponder()
            //TODO: Search report
        }
    }
    private var repairReports = [RepairReport]()
    var reports: [NSManagedObject] = []
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchText = searchTextField.text
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Managed object context reference
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Fetch settings from Report Entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Report")
        
        //Fetch to reports
        do {
            reports = try managedContext.fetch(fetchRequest)
        } catch
            let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
        //TODO: Change to repaired and not repaired
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Not Repaired"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "customReportCell", for: indexPath)
//        if let cell = dequeued as? ReportTableViewCell {
//            cell.dataInThisCell =
//        }
        let report = reports[indexPath.row]
        cell.textLabel?.text = report.value(forKeyPath: "reportTitle") as? String
        cell.detailTextLabel?.text = report.value(forKeyPath: "fillDate") as? String
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
                else {
                    return
            }
            //NSManangedObject context
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(reports[indexPath.row])
            self.reports.remove(at: indexPath.row)
            //NSObject context
            //save
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let DestinationViewController = segue.destination as! FormDetailViewController
            DestinationViewController.titleText = "Report Summary"
            if let cell = sender as? ReportTableViewCell, let indexPath = tableView.indexPath(for: cell) {
                //TODO: detail info
            }
        }
    }
    


}
