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
    
    @IBOutlet weak var documentName: UITextField!
    @IBOutlet weak var equipmentImage: UIImageView!
    @IBOutlet weak var applicant: UITextField!
    @IBOutlet weak var fillDate: UITextField!
    @IBOutlet weak var equipmentName: UITextField!
    @IBOutlet weak var equipmentSerialNumber: UITextField!
    @IBOutlet weak var propertyNumber: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        //Date format for new entry
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd 'at' HH:mm"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        //Append data to NSManagedObject array
        let testImage = #imageLiteral(resourceName: "HDMM")
        let report = RepairReport.init(name: documentName.text!, date: dateString, photo: testImage, applicant: applicant.text!, equipmentName: equipmentName.text!, equipmentSerialNumber: equipmentSerialNumber.text!, propertyNumber: propertyNumber.text!, eventDescription: eventDescription.text!)
        //Save to Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DetailRepairReport", in: context)
        let newForm = NSManagedObject(entity: entity!, insertInto: context)
        
        newForm.setValue(report?.name, forKey: "reportName")
        //newForm.setValue(report?.photo, forKey: "equipmentImage")
        newForm.setValue(report?.applicant, forKey: "applicantName")
        newForm.setValue(report?.date, forKey: "fillDate")
        newForm.setValue(report?.equipmentName, forKey: "equipmentName")
        newForm.setValue(report?.equipmentSerialNumber, forKey: "equipmentSerialNumber")
        newForm.setValue(report?.isRepaired, forKey: "isRepaired")
        newForm.setValue(report?.propertyNumber, forKey: "propertyNumber")
        newForm.setValue(report?.eventDescription, forKey: "eventDescription")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == documentName {
            documentName.resignFirstResponder()
            applicant.becomeFirstResponder()
        } else if textField == applicant {
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
        return false
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        if self.eventDescription.isFirstResponder {
            var userInfo = notification.userInfo!
            var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            scrollView.contentInset.bottom = keyboardFrame.size.height
            scrollView.contentOffset = CGPoint(x:0, y:keyboardFrame.size.height)
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        scrollView.contentOffset = .zero
        scrollView.contentInset = .zero
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set underline for the text
        documentName.setBottomBorder()
        applicant.setBottomBorder()
        fillDate.setBottomBorder()
        equipmentName.setBottomBorder()
        equipmentSerialNumber.setBottomBorder()
        propertyNumber.setBottomBorder()
        eventDescription.layer.borderWidth = 1.0
        equipmentImage.image = #imageLiteral(resourceName: "HDMMHNT")
        
        //Resign keyboard when touch outside of text
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
