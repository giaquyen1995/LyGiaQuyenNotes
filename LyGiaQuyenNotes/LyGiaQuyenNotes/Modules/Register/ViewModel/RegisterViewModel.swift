//
//  RegisterViewModel.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import FirebaseAuth
import Combine
class RegisterViewModel: BaseObservableObject {
    @Published var error: Error?
    @Published var isRegistered = false
    @Published var isLoading: Bool = false

    func registerUser(email: String, password: String) {
        self.isLoading = true

        let task = Task {
            do {
                let authResult = try await API.registerUser(email: email, password: password)
                DispatchQueue.main.async {
                    self.error = nil
                    self.isRegistered = true
                    self.isLoading = false
                }
                print("User created: \(authResult.user.uid)")
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
        addTasks([task])
    }
}
