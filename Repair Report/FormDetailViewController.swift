//
//  FormDetailViewController.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/6/20.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit

class FormDetailViewController: UIViewController {
   
    @IBOutlet weak var applicant: UITextField!
    @IBOutlet weak var fillDate: UITextField!
    @IBOutlet weak var equipmentName: UITextField!
    @IBOutlet weak var equipmentSerialNumber: UITextField!
    @IBOutlet weak var propertyNumber: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    
    @IBAction func saveReport(_ sender: UIButton) {
        
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
