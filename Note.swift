//
//  note.swift
//  elevennote
//
//  Created by Paul O'Connor on 5/31/15.
//  Copyright (c) 2015 Paul O'Connor. All rights reserved.
//

import UIKit

class Note: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Note"
    }
    var title : String {
        get {
            return objectForKey("title") as! String
        }
    set {
            setObject(newValue, forKey: "title")
        }
    }
    var text : String {
        get {
            return objectForKey("text") as! String
        }
        set {
            setObject(newValue, forKey: "text")
        }
    }
    @NSManaged var user : PFUser
    
    
}

    
        

