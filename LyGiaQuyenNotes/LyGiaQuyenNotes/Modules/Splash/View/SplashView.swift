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
            // I wanted this place to show the logo at splash a little longer so I delay 0.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    appRouter.checkIfUserIsSignedIn()
                }
            }
        }
    }
}
