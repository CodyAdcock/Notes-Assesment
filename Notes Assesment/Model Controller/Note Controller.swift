//
//  Note Controller.swift
//  Notes Assesment
//
//  Created by Cody on 8/24/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class NoteController{
    //Singleton
    static let shared = NoteController()
    
    //Source of Truth
    var notes: [Note] = []
    
    //Create
    func createNote(_ detail: String){
        let newNote = Note(detail)
        notes.append(newNote)
        saveToPersistentStore()
    }
    
    //Read
    
    
    //Update
    func updateNote(_ note: Note, _ detail: String){
        note.detail = detail
        saveToPersistentStore()
    }
    
    //Delete
    func deleteNote(_ note: Note){
        guard let index = notes.index(of: note) else {return}
        notes.remove(at: index)
        saveToPersistentStore()
        
    }
    
    //MARK: - Persistence
    
    //create a file URL
    func fileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "notes.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        return fullURL
    }
    
    //Use that file URL to encode and save data
    func saveToPersistentStore(){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(notes)
            print(data)
            try data.write(to: fileURL())
        }catch{
            print("Uh Oh. There was an error saving to persistent store \(error) \(error.localizedDescription)")
        }
    }
    
    //Use that file url to load and decode the data
    func loadFromPersistentStore() -> [Note]{
        do{
            let data = try Data(contentsOf: fileURL())
            let decoder = JSONDecoder()
            let notes = try decoder.decode([Note].self, from: data)
            return notes
        }catch{
            print("Uh Oh. There was an error loading from persistent store \(error) \(error.localizedDescription)")
        }
        return[]
    }
    
}
