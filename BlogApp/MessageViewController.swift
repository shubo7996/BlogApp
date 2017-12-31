//
//  MessageViewController.swift
//  BlogApp
//
//  Created by Subhamoy Paul on 12/30/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MessageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var headerField: UITextField!
    
    @IBOutlet weak var contentField: UITextField!
    
    let options = ["Incoming", "Requirement", "Other"]
    var pickerView = UIPickerView()
    
    @IBAction func didTapButton(_ sender: Any) {
        if headerField.text != nil && contentField.text != nil {
            let time = self.getTime()
            let values = ["heading" : headerField.text!, "content" : contentField.text!, "timestamps": time]
            Database.database().reference().child("User").child((Auth.auth().currentUser?.uid)!).child("messages").childByAutoId().updateChildValues(values)
        }
    }
     func getTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        let time = dateFormatter.string(from: date)
        return time
        
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    headerField.text = options[row]
    headerField.resignFirstResponder()
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        headerField.inputView = pickerView
        headerField.textAlignment = .center
        headerField.placeholder = "Select Your Header"
        
        
    }
    
    @IBAction func signOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "signoutSegue", sender: nil)
        } catch let error {
            assertionFailure("Error Signing Out: \(error)")
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
