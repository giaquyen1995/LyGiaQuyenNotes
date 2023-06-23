//
//  APIError.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation

public enum ApiError: Error {
    
    // Throw when an invalid password is entered
    case invalidObject
    
    case invalidMethod
    
    case errors(object:[String:Any])
    
    // Throw in all other cases
    case unexpected(message: String?)
    
    case invalidRequest
    
    case ignoreError
    
    
    public func getErrorObject() -> [String:Any]? {
        if case let .errors(error) = self {
            return error
        }
        return nil
    }
}
