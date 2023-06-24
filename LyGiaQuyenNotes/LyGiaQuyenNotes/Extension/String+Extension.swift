//
//  String+Extension.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation

extension String {
    
    private static var dateFormatter: DateFormatter = {
          let dateFormatter = DateFormatter()
          return dateFormatter
    }()
    func encodedFirebasePathComponent() -> String {
            let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_")
            return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
        }
    
    func convertDateFormat() -> String? {
        let currentDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let targetDateFormat = "yyyy-MM-dd 'at' HH:mm"
        Self.dateFormatter.dateFormat = currentDateFormat
        
        guard let date = Self.dateFormatter.date(from: self) else {
            return nil
        }
        
        Self.dateFormatter.dateFormat = targetDateFormat
        Self.dateFormatter.timeZone = TimeZone.current // Convert to local time zone for output
        
        return Self.dateFormatter.string(from: date)
    }
}
