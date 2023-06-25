//
//  TextFieldView.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI

struct TextFieldView: View {
    var title: String
    var backgroundColor: Color = Color(.systemGray6)

    @Binding var text: String
    var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(backgroundColor)
            .cornerRadius(10.0)
    }
}
