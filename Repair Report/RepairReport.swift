//
//  RepairReport.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/7/12.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit
import CoreData

class RepairReport {
    
    var isRepaired: Bool
    var name: String
    var date: String
    var photo: UIImage?
    var applicant: String
    var equipmentName: String
    var equipmentSerialNumber: String
    var propertyNumber: String
    var eventDescription: String
    
    init?(name: String,
          date: String,
          photo: UIImage?,
          applicant: String,
          equipmentName: String,
          equipmentSerialNumber: String,
          propertyNumber: String,
          eventDescription: String) {
        if name.isEmpty {
            self.name = "Untitled"
        } else {
            self.name = name
        }
        self.isRepaired = false
        self.date = date
        self.photo = photo
        self.applicant = applicant
        self.equipmentName = equipmentName
        self.equipmentSerialNumber = equipmentSerialNumber
        self.propertyNumber = propertyNumber
        self.eventDescription = eventDescription
        
    }
    
}
