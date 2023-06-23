//
//  NotesResponse.swift
//  LyGiaQuyenNotes
//
//  Created by vfa on 22/06/2023.
//

import Foundation

public struct NoteResponse: Codable {
    public let userId: String
    public let notes: [Note]
    
    enum CodingKeys: String, CodingKey {
        case userId = "user"
        case notes = "notes"
    }
    
    init(userId: String, notes:  [Note]) {
        self.userId = userId
        self.notes = notes
    }
    
    private static func parseNoteData(noteId: String, noteData: Any) -> Note? {
        guard let noteDict = noteData as? [String: Any],
              let content = noteDict["content"] as? String,
              let date = noteDict["date"] as? String,
              let title = noteDict["title"] as? String,
              let user = noteDict["user"] as? String else {
            return nil
        }
        
        return Note(id: noteId, title: title, content: content, date: date, user: user)
    }
    
    
    public static func parse(usersData:[String: Any], isGetAll:Bool) -> NoteResponse? {
        var response:NoteResponse?
            if isGetAll {
                var notes: [Note] = []
                let excludeUserId = FireBaseManager.shared.userId
                for (userId, userData) in usersData {
                    
                    guard userId != excludeUserId,
                          let userData = userData as? [String: Any],
                          let notesData = userData["notes"] as? [String: Any] else {
                        continue
                    }
                    
                    for (noteId, noteData) in notesData {
                        guard let note = parseNoteData(noteId: noteId, noteData: noteData) else {
                            continue
                        }
                        
                        notes.append(note)
                    }
                }
                response = NoteResponse(userId: "", notes: notes)
                
            } else {
                
                var notes: [Note] = []
                   for (noteId, noteData) in usersData {
                       guard let note = parseNoteData(noteId: noteId, noteData: noteData) else {
                           continue
                       }
                       notes.append(note)
                   }
                
                response = NoteResponse(userId: "", notes: notes)
            }
            return response
    }
    
}

public struct Note: Codable, Identifiable {
    public var id: String
    public var title: String
    public var content: String
    public var date: String
    public var user: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case date
        case user
    }
    init(id: String, title: String, content: String, date: String, user: String) {
        self.id = id
        self.title = title
        self.content = content
        self.user = user
        self.date = date
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        date = try container.decode(String.self, forKey: .date)
        user = try container.decode(String.self, forKey: .user)
    }
   
}
