//
//  NotesTableViewController.swift
//  elevennote
//
//  Created by Paul O'Connor on 5/31/15.
//  Copyright (c) 2015 Paul O'Connor. All rights reserved.
//  A bunch of this code was written with the help of a Vea Software tutorial on building a Notes App.
//  elevennote is an app created by Eleven Fifty Academy.


import UIKit

class NotesTableViewController: PFQueryTableViewController,
PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    //Array that will hold all objects from localdatastore and parse back end.
    var noteObjects: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (PFUser.currentUser() == nil) {
            
            var logInViewController = PFLogInViewController()
            logInViewController.delegate = self
            var signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            logInViewController.signUpController = signUpViewController
            self.presentViewController(logInViewController, animated: true, completion: nil)
            
        }else{
            //1st one goes and grabs any objects that are locally stored.  Then, it will update local database with new objects.  Does stuff in background while user is messing with device.
            
            self.fetchAllObjectsFromLocalDataStore()
            self.fetchAllObjects()
        }
    }
    //Fetch the local data store.
    func fetchAllObjectsFromLocalDataStore(){
        var query: PFQuery = PFQuery(className: "Note")
        query.fromLocalDatastore() //not backend
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!) //username is equal to name in app
        //only going to get rows inside data model where class is note and column is username.
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if (error == nil) {
                var temp: NSArray = objects as NSArray! //updates the UI.
                self.noteObjects = temp.mutableCopy() as! NSMutableArray //return an array of our objects
                self.tableView.reloadData() //reload tableview
            } else {
                println(error?.userInfo)
            }
        }
    }
    
    func fetchAllObjects() {
        PFObject.unpinAllObjectsInBackgroundWithBlock(nil) //unpins all objects inside the local data store = asynchronous request.
        var query: PFQuery = PFQuery(className: "Note")  //query the back end for a fresh set of objects to back end.
        query.whereKey("username", equalTo: PFUser.currentUser()!.username!)  //makes sure it's the same user.
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in //find asynchronously in background.
            if (error == nil) {
                PFObject.pinAllInBackground(objects, block: nil) //
                self.fetchAllObjectsFromLocalDataStore() //Fetch all objects from data store to update UI
            }else {
                println(error?.userInfo)
            }
        }
    }
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty || !password.isEmpty){
            return true
        } else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to log in")
    }
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        
        if let password = info["password"] as? String {
            return count(password.utf16) >= 8
            
        } else {
            return false
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up")
    }
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed sign up")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return NoteStore.sharedInstance.getCount()
        return self.noteObjects.count
        
    }
    //Grabs all objects and updates the title label and text label.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("notesCell", forIndexPath: indexPath) as! NoteTableViewCell
        
        cell.setupCell(NoteStore.sharedInstance.getNote(indexPath.row))
        
        var object: PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
        cell.noteTitle?.text = object["title"] as? String
        cell.noteText?.text = object["text"] as? String
        
        return cell
    }
    
    //
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("editNoteSegue", sender: self)
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        var upcoming: NotesDetailedViewController = segue.destinationViewController as! NotesDetailedViewController
    //
    //        if (segue.identifier == "editNoteSegue"){
    //            let indexPath = self.tableView.indexPathForSelectedRow()!
    //        var object: PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
    //            upcoming.object = object
    //        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    //    }
    //
    //}
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            NoteStore.sharedInstance.deleteNote(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
        }
    }
    
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using [segue destinationViewController].
        //Pass the selected object to the new view controller.
        var upcoming: NotesDetailedViewController = segue.destinationViewController as! NotesDetailedViewController
        
        if (segue.identifier == "editNoteSegue"){
            let indexPath = self.tableView.indexPathForSelectedRow()!
            var object: PFObject = self.noteObjects.objectAtIndex(indexPath.row) as! PFObject
            upcoming.object = object
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        if (segue.identifier == "editNoteSegue"){
            let noteDetailVC = segue.destinationViewController as! NotesDetailedViewController
            let tableCell = sender as! NoteTableViewCell
            noteDetailVC.note = tableCell.note
            
        }
    }
    
    
    
    @IBAction func savedNotesDetail(segue:UIStoryboardSegue) {
        let noteDetailVC = segue.sourceViewController as! NotesDetailedViewController
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            //            NoteStore.sharedInstance.updateNote(noteDetailVC.note, index: indexPath.row)
            NoteStore.sharedInstance.sort()
            
            var indexPaths = [NSIndexPath]()
            for index in 0...indexPath.row {
                indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
            }
            
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        } else {
            NoteStore.sharedInstance.addNote(noteDetailVC.note)
            tableView.reloadData()
        }
        
    }
}







