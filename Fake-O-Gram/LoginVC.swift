//
//  ViewController.swift
//  Fake-O-Gram
//
//  Created by Akshay Laghate on 14/12/16.
//  Copyright © 2016 INdCODERS. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var etUsername: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func bSignIn(_ sender: UIButton) {
        
        let email = etUsername.text
        let password = etPassword.text
        
        if email != nil, password != nil{
            FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
                if error == nil{
                    print("Akki Logged in with email")
                }
                else{
                  
                    self.createUser(email: email!, pwd: password!)
                    
                }
            })
        }
        
    }
    
    func createUser(email: String, pwd: String){
        FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
            
            if error == nil{
                print("Akki User created successfully with email")
            }
            
            else{
                
                print("Akki Unable to create user: \(error)")
            }
            
        })
    }
    
    @IBAction func fbSIgnIn(_ sender: UIButton) {
        
        let fbMgr = FBSDKLoginManager()
        fbMgr.logIn(withReadPermissions: ["email"], from: self, handler: { ( result, error) in
            
            if error != nil{
                print("unable to lobin with FB")
            }else if result?.isCancelled == true{
                print("User cancelled FB login")
            } else{
                print("Successfully Logged in with FB")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            })
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
        
            if error != nil{
                print("Unable to login with Firebase - \(error)")
            } else{
                print("Successfully Logged in with Firebase")
            }
        
        })
    }
}

