//
//  RepairReport.swift
//  Repair Report
//
//  Created by Nientai Ho on 2018/7/12.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import UIKit

class RepairReport {
    
    var reportName: String
    var reportDate: String
    var reportPhoto: UIImage?

    init(name: String, date: String, photo: UIImage?) {
        self.reportName = name
        self.reportDate = date
        self.reportPhoto = photo
    }

}
