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
        // I wanted this place to show the logo at splash a little longer so I delay 0.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
                if Auth.auth().currentUser != nil {
                    self.state = .home
                    isSignIn = true
                } else {
                    self.state = .signin
                    isSignIn = false
                }
            
        }
    }
}

enum AppState {
    case splash
    case signin
    case home
}
