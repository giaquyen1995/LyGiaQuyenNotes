//
//  AppRouter.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Firebase
@MainActor class AppRouter: BaseObservableObject {
    @Published var state: AppState = .splash
    @Published var isSignIn: Bool = false
    func checkIfUserIsSignedIn() {
        if Auth.auth().currentUser != nil {
            self.state = .home
            isSignIn = true
        } else {
            self.state = .signin
            isSignIn = false
        }
    }
}

enum AppState {
    case splash
    case signin
    case home
}
