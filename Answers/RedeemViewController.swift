//
//  RedeemViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/10/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class RedeemViewController: UIViewController {
    
    var ref: FIRDatabaseReference?
    
    // IndexPath Seems To Be One Off From Dictionary
    
    var completedsurvey = completedsurveys[completedsurveyID]
    
    
    @IBOutlet weak var phonenumbertext: UITextField!
    @IBOutlet weak var fineprintlabel: UILabel!
    @IBOutlet weak var instructionslabel: UILabel!
    @IBOutlet weak var dealimageVIew: UIImageView!
    @IBOutlet weak var dealname: UILabel!
    @IBOutlet weak var newprice: UILabel!
    @IBOutlet weak var savings: UILabel!
    @IBOutlet weak var originalprice: UILabel!
    @IBOutlet weak var companyname: UILabel!
    @IBOutlet weak var expirationdate: UILabel!
    @IBOutlet weak var completeddate: UILabel!
    
    
    
    @IBAction func tapSendPhoneReward(_ sender: Any) {
        
        let phonenumber = phonenumbertext.text!

        ref = FIRDatabase.database().reference()

        let user = FIRAuth.auth()?.currentUser
        
        let uid = user!.uid
        
        ref?.child("Users").child(uid).childByAutoId().setValue(["PhoneNumber" : "\(phonenumber)"])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        
        let storage = FIRStorage.storage()
        
        let storageRef = storage.reference()
        
        self.ref?.child("Surveys").child("\(completedsurvey)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    if each.key == "CompanyName" {
                        
                        self.companyname.text = each.value as? String
                        
                    } else {
                        
                    }
                    
                    if each.key == "OriginalPrice" {
                        
                        self.originalprice.text = each.value as? String
                        
                    }
                    
                    if each.key == "NewPrice" {
                        
                        self.newprice.text = each.value as? String
                        
                    }
                    
                    if each.key == "EndDate" {
                        
                        self.expirationdate.text = "Expires On " + (each.value as! String)
                        
                        
                    }
                    
                    if each.key == "ProductName" {
                        
                        self.dealname.text = each.value as? String
                    }
                    
                    if each.key == "RewardImage" {
                        
                        let rewardimage = each.value as! String
                        
                        let storage = FIRStorage.storage()
                        
                        print ("\(rewardimage)")
                        
                        storage.reference(forURL: "\(rewardimage)").data(withMaxSize: 10*1024*1024, completion: { (data, error) in
                            
                            let rewardphoto = UIImage(data: data!)
                            
                            self.dealimageVIew.image = rewardphoto
                            
                            print("Fuck")
                            
                        })
                        
                        print("Shit")
                    }
                    
                    if each.key == "RewardType" {
                        
                        var rewardtype = each.value as? String
                        
                        if rewardtype == "Coupon" {
                            
                                self.instructionslabel.text = "Have the cashier scane this code"
                            
                            } else {
                                
                                self.instructionslabel.text = "Show This To the Cashier"
                            }
                        }
                    }
                    
                    print("Missed")
                }
            
        })
        
      
        
        let user = FIRAuth.auth()?.currentUser
        
        let uid = user!.uid
        
        self.ref?.child("Users").child(uid).child("CompletedSurveys").queryOrdered(byChild: "ID").queryEqual(toValue: "\(completedsurvey)").observe(.value, with: { (snapshot) in
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    if let datecompleted = each.value["DateCompleted"] as? String{
                        
                        self.completeddate.text = "Completed On \(datecompleted)"
                    }
                }
            }
            
        })
        
        
        print("\(completedsurveyID) Motherhfucker")

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
