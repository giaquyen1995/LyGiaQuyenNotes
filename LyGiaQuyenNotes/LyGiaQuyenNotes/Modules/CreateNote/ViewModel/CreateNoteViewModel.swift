//
//  CreateNoteViewModel.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation
import Firebase
import Combine
@MainActor class CreateNoteViewModel: BaseObservableObject {
    @Published var isSucess = false
    
    func createOrUpDateNote(noteId: String? ,title:String, content:String) {
        
        let task = Task {
            do
            {
                let userID = FireBaseManager.shared.userId
                let email = FireBaseManager.shared.userName
                let date = Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss")
                var id = ""
                if let noteId = noteId {
                    id = noteId
                } else {
                    id = FireBaseManager.shared.ref.child("users").child(userID).child("notes").childByAutoId().key ?? ""
                }
                let newNoteWithID = Note(id: id, title: title, content: content, date: date, user: email)
                try await API.createOrUpdateNote(note: newNoteWithID, userId: userID, noteId: id)
                self.isSucess = true
            } catch {
                self.isSucess = false
            }
        }
        addTasks([task])
    }
}
