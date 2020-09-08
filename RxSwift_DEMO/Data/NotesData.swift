//
//  NotesData.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//


import Foundation

class NoteData : Codable {
    
    var title: String = ""
    var content: String = ""
    var date: String = ""
    var id : String = ""
    
    init(id:String, title:String, content:String , date : String)
    {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
    }
}

