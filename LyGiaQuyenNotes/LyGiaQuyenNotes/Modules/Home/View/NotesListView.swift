//
//  NotesListView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct NotesListView: View {
    @State private var selectedNote: Note? = nil
    @Binding var reloadNote: Bool
    var useOtherNotes: Bool
    var notes: [Note]  = []
    
    var body: some View {
        List(notes) { note in
            notesCell(note, useOtherNotes: useOtherNotes)
                .onTapGesture {
                    selectedNote = note
                }
        } .background(
            NavigationLink(
                destination: CreateNoteView(reloadNote: $reloadNote, note: selectedNote, isEditable: !useOtherNotes),
                isActive: Binding<Bool>(get: { selectedNote != nil }, set: { _ in selectedNote = nil }),
                label: { EmptyView() }
            )
            .hidden()
        )
    }
}

extension NotesListView {
    @ViewBuilder
    func notesCell(_ note: Note, useOtherNotes: Bool) -> some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.headline)
            Text(note.description)
                .font(.subheadline)
                .lineLimit(1)
            Text(note.date.convertDateFormat() ?? "")
                .font(.subheadline)
            if useOtherNotes {
                Text(note.user)
                    .font(.subheadline)
            }
        }
    }
}
