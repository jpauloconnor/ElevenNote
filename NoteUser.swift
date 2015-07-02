//
//  NoteUser.swift
//  ElevenNote
//
//  Created by Paul O'Connor on 7/2/15.
//  Copyright (c) 2015 Paul O'Connor. All rights reserved.
//

import UIKit

class NoteUser: PFUser, PFSubclassing {
    var storedTitles : String {
    get {
        return objectForKey("title") as! String
    }
    set {
        setObject(newValue, forKey: "title")
        }
    }
    var storedTexts : String {
        get {
            return objectForKey("text") as! String
        }
        set {
            setObject(newValue, forKey: "text")
        }
    }
}