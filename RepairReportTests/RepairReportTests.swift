//
//  RepairReportTests.swift
//  RepairReportTests
//
//  Created by Nientai Ho on 2018/7/13.
//  Copyright © 2018年 HNTStudio. All rights reserved.
//

import XCTest
@testable import Repair_Report


class RepairReportTests: XCTestCase {
    //MARK: RepairReport Class Tests
    
    func testRepairReportInitializationSucceed() {
        //Empty name return nil
        let report = RepairReport.init(name: "", date: "12/02/1994", photo: #imageLiteral(resourceName: "HDMM"), applicant: "HNT", equipmentName: "Macbook", equipmentSerialNumber: "SN-0001", propertyNumber: "PN-9999", eventDescription: "SSD failure")
        XCTAssertNil(report)
    }

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
