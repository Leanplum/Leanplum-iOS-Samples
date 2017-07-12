//
//  InboxTableViewController.swift
//  basicSetupSwift
//
//  Created by Matthew Bell on 5/26/17.
//  Copyright © 2017 Leanplum. All rights reserved.
//

import UIKit
import Leanplum

class InboxTableViewController: UITableViewController {

    var inboxMessages: [LPInboxMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawTable()
        
        // Hide unused cell lines from tableview with an overlapping view.
        self.tableView.tableFooterView = UIView.init()
    }
    
    // Override to call whenever the view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        Leanplum.inbox().onChanged {
            self.drawTable()
        }
        
    }
    
    func drawTable(){
        let inbox: LPInbox = Leanplum.inbox()
        
        self.inboxMessages = inbox.allMessages() as! [LPInboxMessage]
        
        // Re-sort the messages to newest first.
        self.inboxMessages.sort(by: { (message1, message2) -> Bool in
            let first: Date = message1.deliveryTimestamp()
                let second: Date = message2.deliveryTimestamp()
        return first > second
        })
        
        self.tableView.reloadSections(NSIndexSet.init(index: 0) as IndexSet, with: UITableViewRowAnimation.automatic)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(Leanplum.inbox().count())
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "InboxMessageCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // Get the Inbox message for this table row.
        let row = indexPath.row
        let message = self.inboxMessages[row]
        
        // Set the cell text and image.
        cell.textLabel?.text = message.title()
        cell.detailTextLabel?.text = message.subtitle()
        if(message.imageFilePath() != nil){
            cell.imageView?.image = UIImage.init(contentsOfFile: message.imageFilePath())
        }
        
        // Set the text style for read and unread messages.
        if(message.isRead()){
            cell.textLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.textColor = UIColor.lightGray
        } else {
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.textColor = UIColor.black
        }

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the message.
            self.inboxMessages[indexPath.row].remove()
        }
    }

    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        // Mark and track the message as read.
        self.inboxMessages[indexPath.row].read()
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
