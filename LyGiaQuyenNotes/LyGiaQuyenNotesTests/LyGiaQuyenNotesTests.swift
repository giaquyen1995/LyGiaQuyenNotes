//
//  LyGiaQuyenNotesTests.swift
//  LyGiaQuyenNotesTests
//
//  Created by vfa on 21/06/2023.
//

import XCTest
@testable import LyGiaQuyenNotes
import Firebase


final class LyGiaQuyenNotesTests: XCTestCase {
    private var result: [Note]?
    private var error: Error?
    private var auth:AuthDataResult?
    var user: User?

    override func setUp() {
        super.setUp()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    func testGetMyNotes() {
        let expectation = XCTestExpectation(description: "Completion my notes")
        
        Task {
            do {
                guard let id = Auth.auth().currentUser?.uid else {return}
                let notes = try await API.getMyNotes(forUser: id)
                DispatchQueue.main.async { [weak self] in
                    self?.result = notes
                    expectation.fulfill()
                }
            } catch let error {
                DispatchQueue.main.async { [weak self] in
                    self?.error = error
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(result, "Result should not be nil")
    }
    
    func testGetOthersNotes() {
        let expectation = XCTestExpectation(description: "Completion other note")
        
        Task {
            do {
                let notes = try await API.getOthersNotes()
                DispatchQueue.main.async { [weak self] in
                    self?.result = notes
                    expectation.fulfill()
                }
            } catch let error {
                DispatchQueue.main.async { [weak self] in
                    self?.error = error
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(result, "Result should not be nil")
    }
    
    
    
    func testFirebaseOperations() {
        let email = "testuser\(Int.random(in: 1000...9999))@example.com"
        let password = "TestPassword123"
        
        let expectation = XCTestExpectation(description: "User registration")
        Task {
            do {
                let user = try await API.registerUser(email: email, password: password)
                XCTAssertNotNil(auth, "Auth should not be nil")
                expectation.fulfill()
            } catch {
                XCTFail("Sign In failed with error: \(error)")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
    }
   
    
    func testSignIn() {
        let email = "giquyen@gmail.com"
        let password = "123456"
        
        let expectation = XCTestExpectation(description: "Sign In")
        
        Task {
            do {
                let auth = try await API.signIn(email: email, password: password)
                XCTAssertNotNil(auth, "Auth should not be nil")
                expectation.fulfill()
            } catch {
                XCTFail("Sign In failed with error: \(error)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    
    func testSignout() {
        let expectation = XCTestExpectation(description: "Completion sign out")
        Task {
            do {
                try Auth.auth().signOut()
                    expectation.fulfill()
                
            } catch {
                    expectation.fulfill()
                XCTFail("Sign out failed with error")
            }
        }
        wait(for: [expectation], timeout: 5)
    }
}
