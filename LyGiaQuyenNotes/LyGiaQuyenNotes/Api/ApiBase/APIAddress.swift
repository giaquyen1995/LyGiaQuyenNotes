//
//  APIAddress.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
public enum AddressApi: String {
    case getMyNotes = "users/{userId}/notes"
    case getOthersNotes =  "users"
    case createAndEditNote = "users/{userId}/notes/{noteId}"
}
