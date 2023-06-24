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
    @Binding var reloadNote: Bool
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
                viewModel.createOrUpDateNote(noteId: note?.id, text: noteText)
            } : nil )
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.$isSucess) { isSucess in
                if isSucess {
                    reloadNote = true
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

