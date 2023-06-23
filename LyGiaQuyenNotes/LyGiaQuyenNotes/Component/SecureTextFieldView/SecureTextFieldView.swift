//
//  SecureTextFieldView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct SecureTextFieldView: View {
    var title: String
       @Binding var text: String
       
       var body: some View {
           SecureField(title, text: $text)
               .padding()
               .background(Color(.systemGray6))
               .cornerRadius(5.0)
       }
}
