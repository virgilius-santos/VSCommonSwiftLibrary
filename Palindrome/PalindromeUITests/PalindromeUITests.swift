//
//  PalindromeUITests.swift
//  PalindromeUITests
//
//  Created by Virgilius Santos on 21/10/18.
//  Copyright © 2018 Virgilius Santos. All rights reserved.
//

import XCTest

class PalindromeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewController() {
        
        app.launch()
        
        
        let imageView = app.images["checkImageView"]
        XCTAssertEqual(imageView.exists, false)
        
        let button = app.buttons["saveButton"]
        XCTAssertEqual(button.isEnabled, false)
        
        let textField = app.textFields["textField"]
        textField.tap()
        textField.typeText("ababa")
        XCTAssertEqual(textField.value as! String, "ababa")
        textField.typeText("\n")
        
        XCTAssertEqual(imageView.exists, true)
        XCTAssertEqual(button.isEnabled, true)
        
        button.tap()
        XCTAssertEqual(textField.value as! String, "Insira a palavra e descubra")
        XCTAssertEqual(imageView.exists, false)
        XCTAssertEqual(button.isEnabled, false)
        
        textField.tap()
        textField.typeText("ab")
        XCTAssertEqual(imageView.exists, false)
        XCTAssertEqual(button.isEnabled, false)
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        
        app.terminate()
        
    }

}
