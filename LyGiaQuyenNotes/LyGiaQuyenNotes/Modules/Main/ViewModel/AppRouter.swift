//
//  AppRouter.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Firebase
class AppRouter: ObservableObject {
    @Published var state: AppState = .splash
    @Published var isLoggedIn: Bool = false
    func checkIfUserIsSignedIn() {
        if Auth.auth().currentUser != nil {
            self.state = .home
            isLoggedIn = true
        } else {
            self.state = .signin
            isLoggedIn = false
        }
    }
}

enum AppState {
    case splash
    case signin
    case home
}
