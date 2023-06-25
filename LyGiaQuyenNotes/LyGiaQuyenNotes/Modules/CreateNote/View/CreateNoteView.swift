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
    @State private var noteTitle: String = ""
    @State private var noteDescription: String = ""
    @Binding var reloadNote: Bool
    var note: Note?
    var isEditable: Bool
    
    
    var body: some View {
        VStack (spacing: 20) {
            noteTitleView
            noteDescriptionView
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .navigationBarBackButtonHidden(true)
        .navigationTitle(note == nil ? "Create note" : "Update note")
        .navigationBarItems(leading: btnBack, trailing: isEditable ? doneButton : nil)
        .onReceive(viewModel.$isSucess) { isSucess in
            if isSucess {
                reloadNote = true
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .onReceive(viewModel.$isKeyboardActive) { isKeyboardActive in
            self.isKeyboardActive = isKeyboardActive
        }
        .onAppear {
            if let note = note {
                noteTitle = note.title
                noteDescription = note.description
            }
            viewModel.showKeyboard(isEditable: isEditable)
        }
    }
}
private extension CreateNoteView {
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }
    
    
    var noteTitleView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Title")
                .font(.headline)
            TextFieldView(title: "Enter your title", backgroundColor: .white, text: $noteTitle)
                .disabled(!isEditable)
                .focused($isKeyboardActive)
        }
    }
    
    var noteDescriptionView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Description")
                .font(.headline)
            TextEditor(text: $noteDescription)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .disabled(!isEditable)
        }
    }
    private var doneButton: some View {
        Button("Done") {
            viewModel.createOrUpDateNote(noteId: note?.id, title: noteTitle, description: noteDescription)
        }
    }
}
