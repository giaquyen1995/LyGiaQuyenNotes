//
//  HomeViewController.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appRouter: AppRouter
    @State private var selection = 0
    @State private var selectedNote: Note? = nil
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var showingAlert = false
    @State private var isLoading = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var profileButton: some View {
        Button(action: {
            showingAlert = true
        }) {
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
        NavigationLink(destination: CreateNoteView(note: selectedNote, isEditable: true)) {
            Image(systemName: "plus")
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                NotesListView(useOtherNotes: false, notes: viewModel.notes)
                    .tabItem {
                        Label("My Notes", systemImage: "1.square.fill")
                    }
                    .tag(0)
                    .environmentObject(viewModel)
                    .navigationBarTitle("Notes", displayMode: .automatic)
                
                NotesListView(useOtherNotes: true, notes: viewModel.notesOthers)
                    .tabItem {
                        Label("Other's Notes", systemImage: "2.square.fill")
                    }
                    .tag(1)
                    .environmentObject(viewModel)
                    .navigationBarTitle("Notes", displayMode: .automatic)
            }
            .accentColor(Color.blue)
            .modifier(AlertModifier(showAlert: $showingAlert, title: "Sign out", message: "Are you sure?", confirmButtonText: "Sign out", onConfirm: viewModel.signOut))
            .navigationBarItems(leading: profileButton, trailing: createNoteButton)
            .onReceive(appRouter.$isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    viewModel.fetchNotes()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCreateNote)) { _ in
                viewModel.fetchNotes()
            }
        }
        .overlay(isLoading ? ProgressIndicatior() : nil)
        .onReceive(viewModel.$isSignout) { isSignout in
            if isSignout {
                appRouter.state = .signin
            }
        }
        .onReceive(viewModel.$isLoading) { isLoading in
            self.isLoading = isLoading
        }
    }
}
