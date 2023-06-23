//
//  ProgressIndicatior.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import SwiftUI
import UIKit

struct ProgressIndicatior: UIViewRepresentable {
    
    let style: UIActivityIndicatorView.Style
    let color:UIColor
    
    init(style: UIActivityIndicatorView.Style = .medium, color: UIColor = .black) {
        self.style = style
        self.color = color
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView(style: style)
        v.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        v.color = color
        v.hidesWhenStopped = true
        v.startAnimating()
        return v
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.color = color
    }
}
