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
    
    func createOrUpDateNote(noteId: String?, text:String) {
        
        let task = Task {
            do
            {
                let noteParts = text.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true)
                let noteTitle = String(noteParts.first ?? "")
                let noteContent = noteParts.count > 1 ? String(noteParts[1]) : ""
                
                let userID = FireBaseManager.shared.userId
                let email = FireBaseManager.shared.userName
                let date = Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss")
                var id = ""
                if let noteId = noteId {
                    id = noteId
                } else {
                    id = FireBaseManager.shared.ref.child("users").child(userID).child("notes").childByAutoId().key ?? ""
                }
                let newNoteWithID = Note(id: id.encodedFirebasePathComponent(), title: noteTitle, content: noteContent, date: date, user: email)
                try await API.createOrUpdateNote(note: newNoteWithID, userId: userID, noteId: id.encodedFirebasePathComponent())
                self.isSucess = true
            } catch {
                self.isSucess = false
            }
        }
        addTasks([task])
    }
}
