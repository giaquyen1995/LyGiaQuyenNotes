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
    @Published var notes:[Note] = []
    @Published var notesOthers:[Note] = []
    @Published var isLoading: Bool = false
   
    func fetchNotes() {
        self.isLoading = true
        let task =  Task {
            do {
                let notes = try await API.getMyNotes(forUser: FireBaseManager.shared.userId)
                let notesOthers = try await API.getOthersNotes()
                self.notes = notes.sorted(by: { $0.date > $1.date })
                self.notesOthers = notesOthers.sorted(by: { $0.date > $1.date })
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
                self.notes = []
                self.notesOthers = []
                self.isSignout = true
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        addTasks([task])
    }
 
    
}
