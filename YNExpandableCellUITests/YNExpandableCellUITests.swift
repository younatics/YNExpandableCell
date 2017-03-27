//
//  YNExpandableCellUITests.swift
//  YNExpandableCellUITests
//
//  Created by YiSeungyoun on 2017. 3. 28..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import XCTest

class YNExpandableCellUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 1).staticTexts["YNSlider Cell"].tap()
        tablesQuery.children(matching: .cell).element(boundBy: 3).staticTexts["YNSegment Cell"].tap()
        tablesQuery.buttons["Third"].swipeUp()
        tablesQuery.children(matching: .cell).element(boundBy: 9).staticTexts["YNNonExpandable Cell"].tap()
        
        let ynsliderCellStaticText = tablesQuery.children(matching: .cell).element(boundBy: 8).staticTexts["YNSlider Cell"]
        ynsliderCellStaticText.tap()
        
        let ynsegmentCellStaticText = tablesQuery.children(matching: .cell).element(boundBy: 7).staticTexts["YNSegment Cell"]
        ynsegmentCellStaticText.tap()
        ynsegmentCellStaticText.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 6).staticTexts["YNSegment Cell"].tap()
        ynsegmentCellStaticText.tap()
        ynsliderCellStaticText.tap()
        
        let ynexpandablecellNavigationBar = app.navigationBars["YNExpandableCell"]
        ynexpandablecellNavigationBar.buttons["Expand All"].tap()
        ynexpandablecellNavigationBar.buttons["Collapse All"].tap()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
