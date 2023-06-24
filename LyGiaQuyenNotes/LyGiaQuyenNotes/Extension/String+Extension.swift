//
//  String+Extension.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation

extension String {
    
    func encodedFirebasePathComponent() -> String {
            let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_")
            return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
        }
    
    func convertDateFormat() -> String? {
        let currentDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let targetDateFormat = "yyyy-MM-dd 'at' HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentDateFormat
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = targetDateFormat
        dateFormatter.timeZone = TimeZone.current // Convert to local time zone for output
        
        return dateFormatter.string(from: date)
    }
}
