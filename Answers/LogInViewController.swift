//
//  LogInViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/11/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FBSDKLoginKit
import FBSDKCoreKit

class LogInViewController: UIViewController {
    
    var signupMode = true
        
    var ref: FIRDatabaseReference?
   
    @IBOutlet weak var nametext: UITextField!
    
    @IBOutlet weak var errormessage: UILabel!
    @IBOutlet weak var tapsignuporlogin: UIButton!
    @IBOutlet weak var passwordtext: UITextField!
    @IBAction func tapSignUpOrLogin(_ sender: Any) {
        
        if signupMode {
            
            ref = FIRDatabase.database().reference()
            
            let email = nametext.text
            let password = passwordtext.text
            
            
            
            FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user: FIRUser?, error) in
                
                if error != nil {
                    
                    var errorMessage = "Signup failed - please try again"
                    
                    let error = error as? NSError
                    
                    if let parseError = error?.userInfo["error"] as? String {
                        
                        errorMessage = parseError
                    }
                    
                    self.errormessage.text = errorMessage
                    
                } else {
                    
                    let uid = user!.uid
                    
                    UserDefaults.standard.setValue(user?.uid, forKey: "uid")
                    
                FIRDatabase.database().reference().child("Users").child(uid).setValue(["email" : email,"password" : password])
                    
                    self.performSegue(withIdentifier: "LogInToHome", sender: self)
                    
                    UserDefaults.standard.set(true, forKey:"loggedin");


                }
            })
            
        } else {
            
            ref = FIRDatabase.database().reference()
            
            let email = nametext.text
            let password = passwordtext.text
            
            FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
                
                if error != nil {
                    
                    var errorMessage = "Signup failed - please try again"
                    
                    let error = error as? NSError
                    
                    if let parseError = error?.userInfo["error"] as? String {
                        
                        errorMessage = parseError
                        
                    }
                    
                    self.errormessage.text = errorMessage
                    
                }
                        else {
                 
                    self.performSegue(withIdentifier: "LogInToHome", sender: self)

                    UserDefaults.standard.set(true, forKey:"loggedin");

                }
            }
        }
    }
    
    @IBOutlet weak var changesignupmode: UIButton!
    @IBAction func changeSignUpMode(_ sender: Any) {
        
        if signupMode {
            
            signupMode = false
            
            tapsignuporlogin.setImage(UIImage(named: "LogIn"), for: .normal)
            
            changesignupmode.setTitle("Sign Up", for: [])
            
        } else {
            
            signupMode = true
            
            tapsignuporlogin.setImage(UIImage(named: "SignUp"), for: .normal)
            
            changesignupmode.setTitle("Log In", for: [])
            
        }
        
        
    }
    
    
 
    func switchStoryboard() {
        
        performSegue(withIdentifier: "LogInToHome", sender: self)
    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
        
        // Check To See If They Are Signed In
        
        if FIRAuth.auth()?.currentUser != nil {
         
            self.performSegue(withIdentifier: "LogInToHome", sender: self)
            
        } else {
        

            
        
        }

        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.switchStoryboard()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
