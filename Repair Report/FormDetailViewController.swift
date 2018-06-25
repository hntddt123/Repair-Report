//
//  FormDetailViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/20.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit

class FormDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var applicant: UITextField!
    @IBOutlet weak var fillDate: UITextField!
    @IBOutlet weak var equipmentName: UITextField!
    @IBOutlet weak var equipmentSerialNumber: UITextField!
    @IBOutlet weak var propertyNumber: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    
    let equipmentNamePicker = UIPickerView()
    let equipmentData = ["電腦", "螢幕", "網路硬碟", "伺服器", "交換器", "其他"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return equipmentData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return equipmentData[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        equipmentName.text = equipmentData[row]
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applicant.setBottomBorder()
        fillDate.setBottomBorder()
        equipmentName.setBottomBorder()
        equipmentSerialNumber.setBottomBorder()
        propertyNumber.setBottomBorder()
        eventDescription.layer.borderWidth = 1.0
        
        equipmentName.inputView = equipmentNamePicker
        equipmentNamePicker.delegate = self
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
