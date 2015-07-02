//
//  NoteUser.swift
//  ElevenNote
//
//  Created by Paul O'Connor on 7/2/15.
//  Copyright (c) 2015 Paul O'Connor. All rights reserved.
//

import UIKit

class NoteUser: PFUser, PFSubclassing {
    var storedNotes : String {
    get {
        return objectForKey("storedNotes") as! String
    }
    set {
        setObject(newValue, forKey: "storedNotes")
        }
    }
}