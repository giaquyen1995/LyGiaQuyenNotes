//
//  SignInView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @EnvironmentObject var appRouter: AppRouter
    @ObservedObject var viewModel:SignInViewModel = SignInViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Sign in")
                        .foregroundColor(.blueApp)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Please log in into your account")
                        .font(.headline)
                }
                TextFieldView(title: "Email", text: $username)
                    .keyboardType(.emailAddress)
                SecureTextFieldView(title: "Password", text: $password)
                Button(action: {
                    self.viewModel.signin(email: self.username, password: self.password)
                }) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blueApp)
                        .cornerRadius(10.0)
                }
                
                NavigationLink(destination: RegisterView().environmentObject(appRouter)) {
                    HStack(spacing: 0) {
                        Text("Don't have an account? ")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.blueApp)
                    }
                }
                Spacer()
            }
            .padding()
            .overlay(viewModel.isLoading ? ProgressIndicatior() : nil)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("\(viewModel.error?.localizedDescription ?? "Unknown error")"), dismissButton: .default(Text("OK")))
            }
            .onReceive(viewModel.$isSignin) { isSignin in
                if isSignin {
                    appRouter.state = .home
                    appRouter.isSignIn = true
                }
            }
            .onReceive(viewModel.$error) { error in
                if error != nil {
                    self.showAlert = true
                }
            }
        }
        .accessibilityIdentifier("signinScreenElement") // for unit test
        
    }
}
