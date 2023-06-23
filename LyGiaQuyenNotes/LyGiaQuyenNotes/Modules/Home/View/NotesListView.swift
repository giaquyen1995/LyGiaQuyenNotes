//
//  NotesListView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct NotesListView: View {
    @State private var selectedNote: Note? = nil
    var useOtherNotes: Bool
    var notes: [Note]  = []
    
    var body: some View {
        List(notes) { note in
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.headline)
                Text(note.content)
                    .font(.subheadline)
                Text(note.date.convertDateFormat() ?? "")
                    .font(.subheadline)
                if useOtherNotes {
                    Text(note.user)
                        .font(.subheadline)
                }
            }.onTapGesture {
                selectedNote = note
            }
        } .background(
            NavigationLink(
                destination: CreateNoteView(note: selectedNote, isEditable: !useOtherNotes),
                       isActive: Binding<Bool>(get: { selectedNote != nil }, set: { _ in selectedNote = nil }),
                       label: { EmptyView() }
                   )
            .hidden()
        )
    }
}
