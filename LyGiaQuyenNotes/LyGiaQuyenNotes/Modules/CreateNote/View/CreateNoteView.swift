//
//  CreateNoteView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct CreateNoteView: View {
    @StateObject var viewModel = CreateNoteViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState private var isKeyboardActive: Bool
    @State private var noteText: String = ""
    var note: Note?
    var isEditable: Bool
    var body: some View {
        TextEditor(text: $noteText)
            .padding()
            .background(Color(UIColor.systemBackground))
            .onAppear {
                noteText = note != nil ? "\(note!.title)\n\(note!.content)" : ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isKeyboardActive = isEditable ? true : false
                }
            }
            .focused($isKeyboardActive)
            .disabled(!isEditable)
            .navigationBarItems(trailing: isEditable ?  Button("Done") {
                let noteParts = noteText.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true)
                let noteTitle = String(noteParts.first ?? "")
                let noteContent = noteParts.count > 1 ? String(noteParts[1]) : ""
                
                print("Create note with title \(noteTitle) and content \(noteContent)")
                if let existingNote = note {
                    viewModel.updateNote(id: existingNote.id, title: noteTitle, content: noteContent, date: Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss"))
                } else {
                    print("data format: \(Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss"))")
                    viewModel.createNote(title: noteTitle, content: noteContent, date: Date().toString(format: "yyyy-MM-dd'T'HH:mm:ss"))
                }
            } : nil )
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.$isSucess) { isSucess in
                if isSucess {
                    NotificationCenter.default.post(name: .didCreateNote, object: nil)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

