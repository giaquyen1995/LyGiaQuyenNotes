//
//  SignUpView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//


import SwiftUI


struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var registerViewModel:RegisterViewModel = RegisterViewModel()
    @EnvironmentObject var appRouter: AppRouter
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var isLoading = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            registerHeader
            inputForm
            signUpButton
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .accentColor(.black)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("\(registerViewModel.error?.localizedDescription ?? "Unknown error")"), dismissButton: .default(Text("OK")))
        }
        .overlay(isLoading ? ProgressIndicatior() : nil)
        .onReceive(registerViewModel.$isRegistered) { isRegistered in
            if isRegistered {
                registerViewModel.hideKeyboard()
                appRouter.state = .home
                appRouter.isSignIn = true
                
            }
        }
        .onReceive(registerViewModel.$error) { error in
            if error != nil {
                self.showAlert = true
            }
        }
        .onReceive(registerViewModel.$isLoading) { isLoading in
            self.isLoading = isLoading
        }
        
    }
}

extension RegisterView {
    var btnBack: some View {
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
    
    var registerHeader: some View {
        VStack(alignment: .leading) {
            Text("Sign up")
                .foregroundColor(.blueApp)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Please create a new account")
                .font(.headline)
        }
    }
    
    var signUpButton: some View {
        Button(action: {
            registerViewModel.registerUser(email: username, password: password)
        }) {
            Text("Sign up")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blueApp)
                .cornerRadius(10.0)
        }
    }
    
    var inputForm: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextFieldView(title: "Email", text: $username)
                .keyboardType(.emailAddress)
            SecureTextFieldView(title: "Password", text: $password)
            SecureTextFieldView(title: "Confirm password", text: $confirmPassword)
        }
        
    }
}
