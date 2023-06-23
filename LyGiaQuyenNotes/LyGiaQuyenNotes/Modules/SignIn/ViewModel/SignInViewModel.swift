//
//  SignInViewModel.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import FirebaseAuth
import Combine

class SignInViewModel: BaseObservableObject {
    @Published var error: Error?
    @Published var isSignin = false
    
    func signin(email: String, password: String)  {
        let task = Task {
            do {
                let authResult = try await API.signIn(email: email, password: password)
                DispatchQueue.main.async {
                               self.error = nil
                               self.isSignin = true
                           }
                print("User signed in: \(authResult.user.uid)")
            } catch {
                DispatchQueue.main.async {
                                self.error = error
                                self.isSignin = false
                            }
            }
        }
        addTasks([task])
        
    }
    
}
