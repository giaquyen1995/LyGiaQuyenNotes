//
//  HomeViewController.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject var viewModel = HomeViewModel()
    @State private var showingAlert = false
    @State private var isLoading = false
    @State private var selection = 0
    @State private var selectedNote: Note? = nil
    @State private var reloadNote = false
    @State var myNotes:[Note] = []
    @State var othersNotes:[Note] = []
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                myNotesView
                othersNotesView
            }
            .accentColor(.blue)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: profileButton, trailing: createNoteButton)
            .modifier(AlertModifier(showAlert: $showingAlert,
                                    title: "Sign out",
                                    message: "Are you sure?",
                                    confirmButtonText: "Sign out",
                                    onConfirm: { Task {
                viewModel.signOut()
            }}))
            
        }
        .overlay(isLoading ? ProgressIndicatior() : nil)
        .onReceive(appRouter.$isSignIn) {isSignIn in
            if isSignIn {
                viewModel.fetchNotes()
            }
        }
        .onReceive(viewModel.$myNotes.combineLatest(viewModel.$othersNotes), perform: { (myNotes,otherNotes) in
            self.myNotes = myNotes
            self.othersNotes = otherNotes
        })
        .onChange(of: reloadNote) { _ in
            viewModel.fetchNotes()
            reloadNote = false
        }
        .onReceive(viewModel.$isSignout) { appRouter.state = $0 ? .signin : appRouter.state }
        .onReceive(viewModel.$isLoading) { isLoading = $0 }
        .accessibilityIdentifier("homeScreenElement") // for unit test
        
    }
}

// MARK: - Computed Properties
private extension HomeView {
    var profileButton: some View {
        Button(action: { showingAlert = true }) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                Text(FireBaseManager.shared.userName)
                    .fontWeight(.bold)
            }
        }
    }
    
    var createNoteButton: some View {
        NavigationLink(destination: CreateNoteView(reloadNote: $reloadNote, note: selectedNote, isEditable: true)) {
            Image(systemName: "plus")
        }
    }
    
    var myNotesView: some View {
        NotesListView(reloadNote: $reloadNote, useOtherNotes: false, notes: myNotes)
            .tabItem {
                Label("My Notes", systemImage: "1.square.fill")
            }
            .tag(0)
    }
    
    var othersNotesView: some View {
        NotesListView(reloadNote: $reloadNote, useOtherNotes: true, notes: othersNotes)
            .tabItem {
                Label("Other's Notes", systemImage: "2.square.fill")
            }
            .tag(1)
    }
    
}

