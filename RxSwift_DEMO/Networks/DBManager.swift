//
//  DBManager.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import SQLite3
import SwiftSpinner

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(fileURL.path ) \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS NOTES(Id TEXT,title TEXT,content TEXT ,date DATETIME);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("NOTES table created.")
            } else {
                print("NOTES table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(id:String, title:String, content:String , date : String)
    {
        let noteData = read()
        for note in noteData
        {
            if note.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO NOTES (id,title , content , date) VALUES ( ?, ? , ? ,?);"
        print(db , insertStatementString )
        var insertStatement: OpaquePointer? = nil
        print(sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil))
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (content as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (date as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
              print("error preparing insert: \(errmsg)")
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        

    
    }
    
    func read() -> [NoteData] {
        let queryStatementString = "SELECT * FROM NOTES ORDER BY date DESC;"
        var queryStatement: OpaquePointer? = nil
        var note : [NoteData] = []
        
        
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let content = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let dateString = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                            let df = DateFormatter()
                            df.locale = Locale(identifier: "en_US_POSIX")
                            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                            let date = df.date(from: dateString)
                
                note.append(NoteData(id: id, title: title, content: content, date:dateString))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return note
    }
    
    func deleteByID(id:String) {
        let deleteStatementStirng = "DELETE FROM NOTES WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
          sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil)
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func update(id:String, title:String, content:String){
        
    let updateStatementString = "UPDATE NOTES SET title = '\(title)' , content = '\(content)'   WHERE id = \(id);"
      var updateStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("\nSuccessfully updated row.")
//            SwiftSpinner.show("Successfully Saved... ")
        } else {
          print("\nCould not update row.")
           
        }
      } else {
        print("\nUPDATE statement is not prepared")
//        SwiftSpinner.show("Saving This Note...").addTapHandler({
//                      SwiftSpinner.hide()
//                    }, subtitle: "Somethings Went Wrong")
      }

      sqlite3_finalize(updateStatement)
    }
    
}



