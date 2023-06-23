//
//  AlertModifier.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var showAlert: Bool
    let title: String
    let message: String
    let confirmButtonText: String
    let onConfirm: () -> Void  // A closure that represents the confirm action
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showAlert) {
                Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text(confirmButtonText)) {
                    onConfirm()  // Call the confirm action here
                }, secondaryButton: .cancel())
            }
    }
}
