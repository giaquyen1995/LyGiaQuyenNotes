//
//  FireBaseManager.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Firebase
import Combine

class FireBaseManager {
    static let shared = FireBaseManager()

    var userName: String {
        get {
            return Auth.auth().currentUser?.email ?? "No name"
        }
    }
    var userId: String {
        get {
            return Auth.auth().currentUser?.uid ?? ""
        }
    }
    
    var ref: DatabaseReference!
    init(){
        ref = Database.database().reference()
    }
    
}
