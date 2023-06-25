//
//  SplashView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appRouter: AppRouter
    var body: some View {
        VStack {
            Image("image_splash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }.onAppear {
            withAnimation {
                appRouter.checkIfUserIsSignedIn()
            }
        }
    }
}
