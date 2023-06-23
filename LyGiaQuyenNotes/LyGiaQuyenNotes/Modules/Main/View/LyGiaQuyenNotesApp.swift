//
//  LyGiaQuyenNotesApp.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 21/06/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct LyGiaQuyenNotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var appRouter = AppRouter()
    @ViewBuilder
    var rootView: some View {
        switch appRouter.state {
        case .splash:
            SplashView()
        case .signin:
            SignInView()
        case .home:
            HomeView()
            
        }
    }
    
    var body: some Scene {
        WindowGroup {
            rootView
                .environmentObject(appRouter)        }
    }
}
