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
            FirebaseApp.configure()
            
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    
    func testSignIn() {
        let email = "giaquyen@gmail.com"
        let password = "123456"
        
        let expectation = XCTestExpectation(description: "Sign In \(Int.random(in: 0...9999))")
        
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
        let expectation = XCTestExpectation(description: "Completion sign out \(Int.random(in: 0...9999))")
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
    
    func testGetMyNotes() {
        let expectation = XCTestExpectation(description: "Completion my notes \(Int.random(in: 0...9999))")
        
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
        let expectation = XCTestExpectation(description: "Completion other note \(Int.random(in: 0...9999))")
        
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
    
    
    func testRegister() {
        let email = "testuser\(Int.random(in: 1000...9999))@example.com"
        let password = "TestPassword123"
        
        let expectation = XCTestExpectation(description: "User registration \(Int.random(in: 0...9999))")
        Task {
            do {
                _ = try await API.registerUser(email: email, password: password)
                XCTAssertNotNil(auth, "Auth should not be nil")
                expectation.fulfill()
            } catch {
                XCTFail("Sign In failed with error: \(error)")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
    }
   
  
    
    func generateRandomString() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
        let length = 10
        var randomString = ""
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomString.append(character)
        }
        
        return randomString
    }
    
    func testCreateNote() {
        let userID = FireBaseManager.shared.userId
        let email = FireBaseManager.shared.userName
        let title = "noteTitle2"
        let description = "noteContent"
        let date = Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss")
        let id = generateRandomString()

        let expectation = XCTestExpectation(description: "Create note \(Int.random(in: 0...9999))")
        
        Task {
            do {
                try await API.createOrUpdateNote(note: Note(id: id, title: title, description: description, date: date, user: ""), userId: userID, noteId: id)
                expectation.fulfill()
            } catch {
                XCTFail("Sign In failed with error: \(error)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
}
