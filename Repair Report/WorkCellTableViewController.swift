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
    //Report model
    var reports = [NSManagedObject]()
    //TODO:Repair Report Model
    //private var repairReports = [RepairReport]()

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
        //Fetch Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DetailRepairReport")
        do {
            reports = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        let report = reports[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customReportCell", for: indexPath)
        if let reportCell = cell as? ReportTableViewCell {
            reportCell.reportName.text = report.value(forKey: "reportName") as? String
            reportCell.reportDate.text = report.value(forKey: "fillDate") as? String
            reportCell.reportImageView.image = UIImage(named: "HDMM.JPG")
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(reports[indexPath.row])
            reports.remove(at: indexPath.row)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newFormSegue" {
            //let DestinationViewController = segue.destination as! FormDetailViewController
            //DestinationViewController.titleText = "Report Summary"
//            if let cell = sender as? ReportTableViewCell, let indexPath = tableView.indexPath(for: cell) {
//                //TODO: detail info
//            }
        }
    }
    


}

