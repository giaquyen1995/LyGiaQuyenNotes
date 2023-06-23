//
//  FibaseAPI.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Firebase
public extension API {
    
    static func getMyNotes(forUser userId: String) async throws -> [Note] {
        let params: [String: Any] = ["userId": userId]
        let data = try await request(url: .getMyNotes, method: .get, params: params)

        if let data = data as? NoteResponse {
            return data.notes

        }
        throw ApiError.invalidObject

    }

    static func getOthersNotes() async throws -> [Note] {
        let data = try await request(url: .getOthersNotes, method: .get, params: [:])

        if let data = data as? NoteResponse {
            return data.notes

        }
        throw ApiError.invalidObject
    }

    static func createNote(note: Note, userId: String, noteId: String) async throws {
        let _ = try await request(url: .createAndEditNote, method: .post, header: ["userId": userId, "noteId": noteId], params: note.asDictionary())
    }
    
    static func signIn(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                }
            }
        }
    }
   
    static func registerUser(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                }
            }
        }
    }
    
}
