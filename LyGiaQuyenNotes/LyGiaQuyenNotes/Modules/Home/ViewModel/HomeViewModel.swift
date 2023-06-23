//
//  HomeViewModel.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Combine
import Firebase

@MainActor class HomeViewModel: BaseObservableObject {
    @Published var isSignout: Bool = false
    @Published var myNotes:[Note] = []
    @Published var othersNotes:[Note] = []
    @Published var isLoading: Bool = false
   
    func fetchNotes() {
        self.isLoading = true
        let task =  Task {
            do {
                let myNotes = try await API.getMyNotes(forUser: FireBaseManager.shared.userId)
                let othersNotes = try await API.getOthersNotes()
                self.myNotes = myNotes.sorted(by: { $0.date > $1.date })
                self.othersNotes = othersNotes.sorted(by: { $0.date > $1.date })
                self.isLoading = false
                
            } catch {
                print("Error fetching notes: \(error)")
                self.isLoading = false
                
            }
        }
        addTasks([task])
    }
    
    func signOut(){
        let task = Task {
            do{
                try Auth.auth().signOut()
                self.myNotes = []
                self.othersNotes = []
                self.isSignout = true
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        addTasks([task])
    }
 
    
}
