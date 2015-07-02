////
////  NoteStore.swift
////  elevennote
////
////  Created by Paul O'Connor on 5/31/15.
////  Copyright (c) 2015 Paul O'Connor. All rights reserved.
////
//
//import UIKit
//
//
//private let NoteStoreInstance = NoteStore()
//
//class NoteStore: NSObject {
//    private var notes : [Note]!
//    
//    class var sharedInstance : NoteStore {
//        return NoteStoreInstance
//    }
//    
//    override init() {
//        super.init()
//        load()
//    }
//    
//    func getNote(index:Int) -> Note {
//        return notes[index]
//    }
//    
//    func addNote(note:Note) {
//        notes.insert(note, atIndex: 0)
//    }
//    
//    func updateNote(note:Note, index:Int) {
//        notes[index] = note
//    }
//    
//    func deleteNote(index: Int) {
//        notes.removeAtIndex(index)
//    }
//    
//    func getCount() -> Int {
//        return notes.count
//    }
//    
//    func sort() {
//        notes = notes.sorted { $0.date.compare($1.date) ==
//            NSComparisonResult.OrderedDescending}
//    }
//        
//    // MARK: saving and loading files
//    private func archiveFilePath() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        let documentsDirectory = paths.first as! String
//        let path = documentsDirectory
//            .stringByAppendingPathComponent("NotesStore.plist")
//        return path
//    }
//    
//    func save() {
//        NSKeyedArchiver.archiveRootObject(notes, toFile: archiveFilePath())
//    }
//    private func load () {
//            let filePath = archiveFilePath()
//            let fileManager = NSFileManager.defaultManager()
//        
//        if fileManager.fileExistsAtPath(filePath) {
//            notes = NSKeyedUnarchiver.unarchiveObjectWithFile(archiveFilePath()) as! [Note]
//        } else {
//            notes = [Note]()
//            var note1 = Note()
//            note1.title = "Note 1"
//            note1.text = "This is a note"
//            notes.append(note1)
//            var note2 = Note(title: "Note 2", text: "This is another note")
//            notes.append(note2)
//            notes.append(Note(title: "Note 3", text: "This is a bear.  Just kidding.  It's a note"))
//
////            /* Cleaner option
////            var note1 = Note(title: "Note 1", text: "This is a note")
////            var note3 = Note(title: "Note 3", text: "This is a bear.")
////            notes.append(note1)
////            notes.append(note3)
////            */
////
//    
//        }
//        sort()
//    }
//}
