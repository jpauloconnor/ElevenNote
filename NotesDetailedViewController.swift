//
//  NotesDetailedViewController.swift
//  elevennote
//
//  Created by Paul O'Connor on 5/31/15.
//  Copyright (c) 2015 Paul O'Connor. All rights reserved.
//

import UIKit

class NotesDetailedViewController: UIViewController {
    var note = Note()
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    var object: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text = note.title
        noteText.text = note.text
        
        if (self.object != nil) {
            
            self.noteTitle.text = self.object["title"] as! String
            self.noteText.text = self.object["text"] as! String
        } else {
            self.object = PFObject(className: "Note")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //This saves objects to the backend.
    @IBAction func saveAction(sender: UIBarButtonItem) {
    self.object["username"] = PFUser.currentUser()!.username!
    self.object["title"] = self.noteTitle.text
    self.object["text"] = self.noteText.text
            //How do I get one for the date? 
        
        self.object.saveEventually { (succes, error) -> Void in
            if (error == nil) {
                
            } else {
                println(error?.userInfo)
            }
        }
    self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                note.title = noteTitle.text
        note.text = noteText.text
        note.date = NSDate()
    }
   

}
