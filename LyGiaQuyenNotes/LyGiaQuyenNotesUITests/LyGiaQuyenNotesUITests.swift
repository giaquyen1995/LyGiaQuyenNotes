//
//  LyGiaQuyenNotesUITests.swift
//  LyGiaQuyenNotesUITests
//
//  Created by vfa on 21/06/2023.
//

import XCTest

final class LyGiaQuyenNotesUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
                        measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSignin() throws {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        
        app.launch()
        
        let possibleLoggedInEmailButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons.firstMatch
           if possibleLoggedInEmailButton.exists {
               possibleLoggedInEmailButton.tap()
               app.alerts["Sign out"].scrollViews.otherElements.buttons["Sign out"].tap()
           }
        
        
        let usernameField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let signInButton = app.buttons["Sign in"]
        // Tap on the fields and enter text
        usernameField.tap()
        usernameField.typeText("giaquyen@gmail.com")
        
        passwordField.tap()
        passwordField.typeText("123456")
        
        // Tap on the sign in button
        signInButton.tap()
        let homeScreenElement = app.otherElements["homeScreenElement"]

        XCTAssertTrue(homeScreenElement.waitForExistence(timeout: 5))
        
    }
    
    func testSignup() throws {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        
        app.launch()
        
        let possibleLoggedInEmailButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons.firstMatch
           if possibleLoggedInEmailButton.exists {
               possibleLoggedInEmailButton.tap()
               app.alerts["Sign out"].scrollViews.otherElements.buttons["Sign out"].tap()
           }
        
        XCUIApplication().buttons["Don't have an account? , Sign Up"].tap()

        
        let usernameField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let confirmPasswordField = app.secureTextFields["Confirm password"]
        
        let signupButton = app.buttons["Sign up"]
        // Tap on the fields and enter text
        usernameField.tap()
        usernameField.typeText("giaquyen30@gmail.com")
        
        passwordField.tap()
        passwordField.typeText("123456")
        
        confirmPasswordField.tap()
        confirmPasswordField.typeText("123456")
        
        // Tap on the sign in button
        signupButton.tap()
        let homeScreenElement = app.otherElements["homeScreenElement"]

        XCTAssertTrue(homeScreenElement.waitForExistence(timeout: 5))
        
    }
    func testCreateNote() throws {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
        let homeScreenElement = app.otherElements["homeScreenElement"]
        let signinView = app.otherElements["signinScreenElement"]

        if homeScreenElement.exists {
            app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Thêm"].tap()
            let title = app.textFields["Enter your title"]

            let textView = app.otherElements["homeScreenElement"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
            
            title.tap()
            title.typeText("new note")
            
            textView.tap()
            textView.typeText("helolol")
        
            app.navigationBars["Create note"].buttons["Done"].tap()
        } else if signinView.exists {
            let usernameField = app.textFields["Email"]
            let passwordField = app.secureTextFields["Password"]
            let signInButton = app.buttons["Sign in"]
            // Tap on the fields and enter text
            usernameField.tap()
            usernameField.typeText("giaquyen@gmail.com")
            
            passwordField.tap()
            passwordField.typeText("123456")
            
            // Tap on the sign in button
            signInButton.tap()
            
            app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Thêm"].tap()
            let title = app.textFields["Enter your title"]

            let textView = app.otherElements["homeScreenElement"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
            
            title.tap()
            title.typeText("new note")
            
            textView.tap()
            textView.typeText("helolol")
        
            app.navigationBars["Create note"].buttons["Done"].tap()
        }
        
        XCTAssertTrue(homeScreenElement.waitForExistence(timeout: 5))
        
    }
    
}
