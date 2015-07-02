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
    var title : NoteUser {
        get {
            return objectForKey("title") as! NoteUser
        }
    set {
            setObject(newValue, forKey: "title")
        }
    }
    var text : NoteUser {
        get {
            return objectForKey("text") as! NoteUser
        }
        set {
            setObject(newValue, forKey: "text")
        }
    }
}

    
        

//    
//    var dateString : String {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        return dateFormatter.stringFromDate(date)
//    }
//    
//    override init(){   //Why is this initializer here?
//        super.init()
//    }
//    
//    init(title:String, text:String) {
//        self.title = title
//        self.text = text
//    }
//
//    required init(coder aDecoder: NSCoder){
//        self.title = aDecoder.decodeObjectForKey("title") as! String
//        self.text = aDecoder.decodeObjectForKey("text") as! String
//        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
//        
//    }
//
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(title, forKey: "title")
//        aCoder.encodeObject(text, forKey: "text")
//        aCoder.encodeObject(date, forKey: "date")
//        
//    }
//    
//}

