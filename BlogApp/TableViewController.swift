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
    var IdArray = [String]()
    
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let header = headerArray[indexPath.row]
        let content = contentArray[indexPath.row]
        let alertController = UIAlertController(title: "", message: "Do whatever you Want to", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            let id = self.IdArray[indexPath.row]
            let heading = alertController.textFields?[0].text
            let content = alertController.textFields?[1].text
            self.updateMessage(heading: heading!, content: content!, id: id)
            
        }
        
                
    
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
            let id = self.IdArray[indexPath.row]
            self.deleteMessage(id: id)
        }
        alertController.addTextField { (textField) in
            textField.text = header
        }
        alertController.addTextField { (textField) in
            textField.text = content
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateMessage(heading: String, content: String, id: String){
        let time = self.getTime()
        let values = ["heading" : heading, "content" : content, "timestamps" : time]
        Database.database().reference().child("User").child((Auth.auth().currentUser?.uid)!).child("messages").child(id).updateChildValues(values)
        
        self.messageTableView.reloadData()
    }
    
    func deleteMessage(id: String){
        Database.database().reference().child("User").child((Auth.auth().currentUser?.uid)!).child("messages").child(id).setValue(nil)
        
        self.messageTableView.reloadData()
        
    }
    
    func getTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        let time = dateFormatter.string(from: date)
        return time
        
    }
    
    func gettingMessageInfo(){
        if Auth.auth().currentUser?.uid != nil {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("User").child(uid!).child("messages").observeSingleEvent(of: .value, with: { (snapshot) in
                if !snapshot.exists() {
                    return
                }
                print (snapshot.key)
                print (snapshot.value!)
                let dictionary = snapshot.value as! NSDictionary
                let dictIDs = dictionary.allKeys
                for id in dictIDs {
                    let singlePost = dictionary[id] as! NSDictionary
                    self.IdArray.append(id as! String)
                    self.headerArray.append(singlePost["heading"] as! String)
                    self.contentArray.append(singlePost["content"] as! String)
                    self.timestampsArray.append((singlePost["timestamps"] as! String))
                }
                print(self.IdArray)
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
