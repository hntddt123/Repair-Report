//
//  FormDetailViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/20.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit
import CoreData

class FormDetailViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var reportTitle: UILabel!
    @IBOutlet weak var applicant: UITextField!
    @IBOutlet weak var fillDate: UITextField!
    @IBOutlet weak var equipmentName: UITextField!
    @IBOutlet weak var equipmentSerialNumber: UITextField!
    @IBOutlet weak var propertyNumber: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    var reportDetails: [NSManagedObject] = []
    
    
    @IBAction func saveReport(_ sender: UIButton) {
        // TODO: Save ReportDetail
        let applicantToSave = applicant.text!
        let fillDateToSave = fillDate.text!
        let equipmentNameToSave = equipmentName.text!
        let equipmentSerialNumberToSave = equipmentSerialNumber.text!
        let propertyNumberToSave = propertyNumber.text!
        let eventDescriptionToSave =  eventDescription.text!
        
        //Save text to Core Data ReportDetail
        save(with: applicantToSave,
             with: fillDateToSave,
             with: equipmentNameToSave,
             with: equipmentSerialNumberToSave,
             with: propertyNumberToSave,
             with: eventDescriptionToSave)

    }
    
    func save(with applicant: String,
              with date: String,
              with equipmentName: String,
              with equipmentSerialNumber: String,
              with propertyNumber: String,
              with eventDescription: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        
        //NSObject context
        let managedContext = appDelegate.persistentContainer.viewContext
        //Insert to NSManagedObject
        let entity = NSEntityDescription.entity(forEntityName: "ReportDetail",
                                                in: managedContext)!
        let reportDetail = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        //key-value coding
        reportDetail.setValue(applicant, forKeyPath: "applicantName")
        reportDetail.setValue(date, forKeyPath: "fillDate")
        reportDetail.setValue(equipmentName, forKeyPath: "equipmentName")
        reportDetail.setValue(equipmentSerialNumber, forKeyPath: "equipmentSerialNumber")
        reportDetail.setValue(propertyNumber, forKeyPath: "propertyNumber")
        reportDetail.setValue(eventDescription, forKeyPath: "eventDescription")
        
        //save to reportDetail Data
        do {
            try managedContext.save()
            //reportDetails.append(reportDetail)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == applicant {
            applicant.resignFirstResponder()
            fillDate.becomeFirstResponder()
        } else if textField == fillDate {
            textField.resignFirstResponder()
            equipmentName.becomeFirstResponder()
        } else if textField == equipmentName {
            textField.resignFirstResponder()
            equipmentSerialNumber.becomeFirstResponder()
        } else if textField == equipmentSerialNumber {
            textField.resignFirstResponder()
            propertyNumber.becomeFirstResponder()
        } else if textField == propertyNumber {
            textField.resignFirstResponder()
            eventDescription.becomeFirstResponder()
        }
        return true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Managed object context reference
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Fetch settings from ReportDetail Entity
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ReportDetail")
        
        //Fetch to reportDetails
        do {
            reportDetails = try managedContext.fetch(fetchRequest)
            for text in reportDetails as [NSManagedObject] {
                applicant.text = text.value(forKey: "applicantName") as? String
                fillDate.text = text.value(forKey: "fillDate") as? String
                equipmentName.text = text.value(forKey: "equipmentName") as? String
                equipmentSerialNumber.text = text.value(forKey: "equipmentSerialNumber") as? String
                propertyNumber.text = text.value(forKey: "propertyNumber") as? String
                eventDescription.text = text.value(forKey: "eventDescription") as? String
            }
        } catch
            let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        reportTitle.text = "Report:"

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set underline for the text
        applicant.setBottomBorder()
        fillDate.setBottomBorder()
        equipmentName.setBottomBorder()
        equipmentSerialNumber.setBottomBorder()
        propertyNumber.setBottomBorder()
        eventDescription.layer.borderWidth = 1.0
        
        //Resign keyboard when touch outside of text
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 0.0
    }
}
