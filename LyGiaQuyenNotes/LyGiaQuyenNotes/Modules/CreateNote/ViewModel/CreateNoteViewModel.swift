//
//  CreateNoteViewModel.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Firebase
import Combine
class CreateNoteViewModel: BaseObservableObject {
    @Published var isSucess = false
    
    func createNote(title:String, content:String, date:String)  {
        let task = Task {
            do
            {
                guard let user = Auth.auth().currentUser else { return }
                let userID = user.uid
                let email = user.email ?? ""

                let key = FireBaseManager.shared.ref.child("users").child(userID).child("notes").childByAutoId().key ?? ""
                let newNoteWithID = Note(id: key, title: title, content: content, date: date, user: email)
                try await API.createNote(note: newNoteWithID, userId: userID, noteId: key)
                await MainActor.run(body: {
                    self.isSucess = true

                })
            }catch {
                
            }
        }
        addTasks([task])
        
    }
    func updateNote(id: String,title:String, content:String, date:String) {
        
        let task = Task {
            do
            {
                guard let user = Auth.auth().currentUser else { return }
                let userID = user.uid
                let email = user.email ?? ""

                let newNoteWithID = Note(id: id, title: title, content: content, date: date, user: userID)
                try await API.createNote(note: newNoteWithID, userId: email, noteId: id)
                await MainActor.run(body: {
                    self.isSucess = true

                })
            }catch {
                
            }
        }
        addTasks([task])
    }
}
