//
//  TableViewController.swift
//  BlogApp
//
//  Created by Subhamoy Paul on 12/31/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageTableView: UITableView!
    var headerArray = [String]()
    var contentArray = [String]()
    var timestampsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        gettingMessageInfo()

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "Cell") as! feedViewCell
        cell.headerText.text = headerArray[indexPath.row]
        cell.contentText.text = contentArray[indexPath.row]
        cell.timestampsText.text = timestampsArray[indexPath.row]
        return cell
    }
    
    func gettingMessageInfo(){
        if Auth.auth().currentUser?.uid != nil {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("User").child(uid!).child("messages").childByAutoId().observe(DataEventType.childAdded, with: { (snapshot) in
                if !snapshot.exists() {
                    return
                }
                print (snapshot.key)
                print (snapshot.value)
                let dictionary = snapshot.value as! NSDictionary
                let messages = dictionary["messages"] as! NSDictionary
                let messagesIDs = messages.allKeys
                
                for id in messagesIDs {
                    let singleMessage = messages[id] as! NSDictionary
                    self.headerArray.append(singleMessage["heading"] as! String)
                    self.contentArray.append(singleMessage["content"] as! String)
                    self.timestampsArray.append(singleMessage["timestamps"] as! String)
                }
                self.messageTableView.reloadData()
            })
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
