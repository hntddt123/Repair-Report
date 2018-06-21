//
//  NewFormViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/20.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit

class NewFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
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
        equipmentName.inputView = equipmentNamePicker
        equipmentNamePicker.delegate = self
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        //TODO: Add new cell with inputText
        let cellName = applicant.text
        cellArray.append(cellName!)
        print(cellArray)
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
    
}
