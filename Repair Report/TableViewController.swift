//
//  TableViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/14.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ReportTableView: UITableView!
    var cellArray = ["1st report","2nd report","3rd report"]
    var cellDetailArray = ["6/12","6/13","6/14"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath)
        cell.textLabel?.text = cellArray[indexPath.row]
        cell.detailTextLabel?.text = cellDetailArray[indexPath.row]
        
        
        
        return cell
    }
    
    @IBAction func RequestForm(_ sender: UIBarButtonItem) {
        //TODO: Add Form to fill
        
        print("Add new form")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReportTableView.delegate = self
        ReportTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

