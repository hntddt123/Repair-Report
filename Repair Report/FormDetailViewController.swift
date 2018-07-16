//
//  FormDetailViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/20.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit
import CoreData

class FormDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {
    
    @IBOutlet weak var documentNameTextField: UITextField!
    @IBOutlet weak var equipmentImageView: UIImageView!
    @IBOutlet weak var applicantTextField: UITextField!
    @IBOutlet weak var fillDateTextField: UITextField!
    @IBOutlet weak var equipmentNameTextField: UITextField!
    @IBOutlet weak var equipmentSerialNumberTextField: UITextField!
    @IBOutlet weak var propertyNumberTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextView!
    @IBOutlet weak var scrollViewTextField: UIScrollView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var reports = [NSObject]()
    var index = 0
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        dismissNavigationVC()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        //Date format for new entry
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd 'at' HH:mm"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        //Append data to NSManagedObject array
        
        let report = RepairReport.init(name: documentNameTextField.text!, date: dateString, photo: equipmentImageView.image, applicant: applicantTextField.text!, equipmentName: equipmentNameTextField.text!, equipmentSerialNumber: equipmentSerialNumberTextField.text!, propertyNumber: propertyNumberTextField.text!, eventDescription: eventDescriptionTextField.text!)
        
        //Save to Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DetailRepairReport", in: context)
        let newForm = NSManagedObject(entity: entity!, insertInto: context)
        
        //Save report to database
        let image: NSData? = UIImageJPEGRepresentation(equipmentImageView.image!, 0.0) as NSData?
        newForm.setValue(report?.name, forKey: "reportName")
        newForm.setValue(image, forKey: "equipmentImage")
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
        dismissNavigationVC()
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard when tap Image
        self.view.endEditing(true)
        let imagePickerController = UIImagePickerController()
        
        let alert = UIAlertController(title: "Choose Image", message: "Please select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo", style: .default , handler:{ (UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction) in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction) in
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        equipmentImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = documentNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    private func dismissNavigationVC() {
        let isPresentingInAddFormMode = presentingViewController is UINavigationController
        if isPresentingInAddFormMode  {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The AddFormController is not inside a navigation controller.")
        }
    }
    
    func loadDetailReport() {
        //Fetch Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DetailRepairReport")
        do {
            reports = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let isPresentingInAddFormMode = presentingViewController is UINavigationController
        if !isPresentingInAddFormMode {
            let report = reports[index]
            let image = report.value(forKey: "equipmentImage") as! NSData
            documentNameTextField.text = report.value(forKey: "reportName") as? String
            equipmentImageView.image = UIImage(data: image as Data)
            applicantTextField.text = report.value(forKey: "applicantName") as? String
            fillDateTextField.text = report.value(forKey: "fillDate") as? String
            equipmentNameTextField.text = report.value(forKey: "equipmentName") as? String
            equipmentSerialNumberTextField.text = report.value(forKey: "equipmentSerialNumber") as? String
            propertyNumberTextField.text = report.value(forKey: "propertyNumber") as? String
            eventDescriptionTextField.text = report.value(forKey: "eventDescription") as? String
            navigationItem.title = documentNameTextField.text
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = documentNameTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == documentNameTextField {
            documentNameTextField.resignFirstResponder()
            applicantTextField.becomeFirstResponder()
        } else if textField == applicantTextField {
            applicantTextField.resignFirstResponder()
            fillDateTextField.becomeFirstResponder()
        } else if textField == fillDateTextField {
            textField.resignFirstResponder()
            equipmentNameTextField.becomeFirstResponder()
        } else if textField == equipmentNameTextField {
            textField.resignFirstResponder()
            equipmentSerialNumberTextField.becomeFirstResponder()
        } else if textField == equipmentSerialNumberTextField {
            textField.resignFirstResponder()
            propertyNumberTextField.becomeFirstResponder()
        } else if textField == propertyNumberTextField {
            textField.resignFirstResponder()
            eventDescriptionTextField.becomeFirstResponder()
        }
        return false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        if self.eventDescriptionTextField.isFirstResponder {
            var userInfo = notification.userInfo!
            var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            scrollViewTextField.contentInset.bottom = keyboardFrame.size.height
            scrollViewTextField.contentOffset = CGPoint(x:0, y:keyboardFrame.size.height)
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        scrollViewTextField.contentInset = .zero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set underline for the text
        documentNameTextField.setBottomBorder()
        applicantTextField.setBottomBorder()
        fillDateTextField.setBottomBorder()
        equipmentNameTextField.setBottomBorder()
        equipmentSerialNumberTextField.setBottomBorder()
        propertyNumberTextField.setBottomBorder()
        eventDescriptionTextField.layer.borderWidth = 1.0
        
        
        //Resign keyboard when touch outside of text
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        loadDetailReport()
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

