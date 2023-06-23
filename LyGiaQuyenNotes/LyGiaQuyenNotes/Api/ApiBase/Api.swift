//
//  Api.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation

public class API:ObservableObject {
    
    enum HttpMethod {
        case get, post
    }
    
    static func request(url: AddressApi, method: HttpMethod, header: [String: Any] = [:], params: [String: Any]) async throws -> Any? {
        var resultPath = url.rawValue
        var isGetAll = true
        
        // Loop to fill the path with header parameters
        for (key, value) in header {
            if let valueString = value as? String {
                resultPath = resultPath.replacingOccurrences(of: "{\(key)}", with: valueString)
            }
        }
        // Loop to fill the path with parameters
        for (key, value) in params {
            if let valueString = value as? String {
                if key == "userId" {
                    isGetAll = false
                }
                resultPath = resultPath.replacingOccurrences(of: "{\(key)}", with: valueString)
            }
        }
        
        let ref = FireBaseManager.shared.ref.child(resultPath)
        if method == .get {
            return try await withCheckedThrowingContinuation { continuation in
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    if let dt = snapshot.value as? [String: Any] {
                        if let res = NoteResponse.parse(usersData: dt, isGetAll: isGetAll) {
                            continuation.resume(returning: res)
                        } else {
                            continuation.resume(throwing: ApiError.invalidObject)
                        }
                    } else {
                        continuation.resume(returning: NoteResponse(userId: "", notes: []))
                    }
                })
            }
        } else if method == .post {
            try await ref.setValue(params)
            return nil
        } else {
            throw ApiError.invalidMethod
        }
    }
    
}
