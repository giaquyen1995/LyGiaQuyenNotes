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
    @Published var isKeyboardActive = false

    func showKeyboard(isEditable:Bool){
        // used to wait display keyboard for UI better
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let `self` = self else {return}
            self.isKeyboardActive = isEditable ? true : false
        }
    }
    
    func createOrUpDateNote(noteId: String?, title:String, description:String) {
        
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
                let newNoteWithID = Note(id: id.encodedFirebasePathComponent(), title: title, description: description, date: date, user: email)
                try await API.createOrUpdateNote(note: newNoteWithID, userId: userID, noteId: id.encodedFirebasePathComponent())
                self.isSucess = true
            } catch {
                self.isSucess = false
            }
        }
        addTasks([task])
    }
    
    
}
