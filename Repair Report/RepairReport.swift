//
//  RepairReport.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/7/12.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit

class RepairReport {
    
    var isRepaired: Bool
    var reportName: String
    var reportDate: String
    var reportPhoto: UIImage?
    var reportApplicant: String
    var reportEquipmentName: String
    var reportEquipmentSerialNumber: String
    var reportPropertyNumber: String
    var reportEventDescription: String
    
    init?(name: String,
         date: String,
         photo: UIImage?,
         applicant: String,
         equipmentName: String,
         equipmentSerialNumber: String,
         propertyNumber: String,
         eventDescription: String) {
        
        if name.isEmpty {
            return nil
        }
        self.isRepaired = false
        self.reportName = name
        self.reportDate = date
        self.reportPhoto = photo
        self.reportApplicant = applicant
        self.reportEquipmentName = equipmentName
        self.reportEquipmentSerialNumber = equipmentSerialNumber
        self.reportPropertyNumber = propertyNumber
        self.reportEventDescription = eventDescription

    }

}
