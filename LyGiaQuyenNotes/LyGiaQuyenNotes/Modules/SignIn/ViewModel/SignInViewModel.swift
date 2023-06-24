//
//  SignInViewModel.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor class SignInViewModel: BaseObservableObject {
    @Published var error: Error?
    @Published var isSignin = false
    @Published var isLoading = false
    
    func signin(email: String, password: String)  {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let task = Task {
                do {
                    let authResult = try await API.signIn(email: email, password: password)
                    self.error = nil
                    self.isSignin = true
                    self.isLoading = false
                    print("User signed in: \(authResult.user.uid)")
                } catch {
                    self.error = error
                    self.isSignin = false
                    self.isLoading = false
                    
                }
            }
            self.addTasks([task])
        }
    }
}
