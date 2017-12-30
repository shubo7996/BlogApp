//
//  ViewController.swift
//  BlogApp
//
//  Created by Subhamoy Paul on 12/30/17.
//  Copyright © 2017 Subhamoy Paul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref: DatabaseReference?

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapEnter(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            if emailText.text != "" && usernameText.text != "" && passwordText.text != "" {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                    if user != nil && error == nil {
                        guard let uid = user?.uid else {
                            return
                        }
                        let values = ["username": self.usernameText.text!, "email": self.self.emailText.text!]
                        
                        self.storingUserIntoFirebase(uid: uid, values: values as [String : AnyObject])
                        //perform segue here
                    } else {
                        let alert = UIAlertController(title: "valid username and password required", message: "You must enter valid details", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        } else {
            if emailText.text != "" && usernameText.text != "" && passwordText.text != "" {
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                    if user != nil && error == nil {
                        //perform Segue
                    }else {
                        let alert = UIAlertController(title: "valid username and password required", message: "You must enter valid details", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    private func storingUserIntoFirebase(uid: String, values: [String:AnyObject]) {
        ref = Database.database().reference()
        let userRef = ref?.child("User").child(uid)
        userRef?.updateChildValues(values)
        
    }


}

