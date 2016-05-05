//
//  CoffeeShopsTableViewControllerTests.swift
//  CoffeeShops
//
//  Created by Yin Hua on 5/05/2016.
//  Copyright © 2016 Yin Hua. All rights reserved.
//
import UIKit
import XCTest
@testable import CoffeeShops


class CoffeeShopsTableViewControllerTests: XCTestCase {
    
    var viewController:CoffeeShopsTableViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CoffeeShopsTableViewController") as! CoffeeShopsTableViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatTableViewLoads(){
        XCTAssertNotNil(viewController.tableView, "TableView not initiated")
        
    }
    
    func testTableViewIsConnectedToDelegate(){
        
         XCTAssertNotNil(viewController.tableView.delegate, "Table delegate cannot be nil");
    }
    
    func testTableViewNumberOfRowsInSection(){

        let array = [["name":"Bar Fresko","Address":"498 Princes Hwy","Distance":"100"]
        ,["name":"Bar Fresko","Address":"498 Princes Hwy","Distance":"100"],["name":"Bar Fresko","Address":"498 Princes Hwy","Distance":"100"]]
        
        viewController.tableData = NSMutableArray(array: array)
        
        let expectedRows = array.count
        
        XCTAssertTrue(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0) == expectedRows,"Table has \(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)) rows but it should have \(expectedRows)")

    }
    
    func testTableViewHeightForRowAtIndexPath(){
        
        let expectedHeight:CGFloat = 60.0;
        let actualHeight = viewController.tableView.rowHeight;
        XCTAssertEqual(expectedHeight, actualHeight, "Cell should have \(expectedHeight) height, but they have \(actualHeight)")
    }
    
    func testTableViewDisplayCurrectInfo(){
        
        
        let name = "Bar Fresk"
        let formattedAddress = "498 Princes Hwy"
        let distance = 100
        
        let array = [["name":name,"location":["formattedAddress":[formattedAddress],"distance":distance]]
            ,["name":"test2","location":["formattedAddress":"499 Princes Hwy","distance":200]]
            ,["name":"test3","location":["formattedAddress":"500 Princes Hwy","distance":300]]]
        
        viewController.tableData = NSMutableArray(array: array)
        viewController.tableView.reloadData()
        let indexPathZero = NSIndexPath(forRow: 0, inSection: 0)

        let cell = viewController.tableView.cellForRowAtIndexPath(indexPathZero) as! CoffeeShopsTableViewCell
        
        
        
        XCTAssertTrue(cell.nameLabel.text! == name,"First coffee shop name is\(cell.nameLabel.text) but it should be \(name)")
        
        XCTAssertTrue(cell.addressLabel.text! == formattedAddress + " ","First coffee shop address is\(cell.addressLabel.text!) but it should be \(formattedAddress) ")

        XCTAssertTrue(cell.distanceLabel.text! == "\(distance)m","First coffee shop distance is\(cell.distanceLabel.text!) but it should be \(distance)m")

        
    }
    
    
    
}
