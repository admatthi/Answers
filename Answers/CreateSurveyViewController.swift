//
//  CreateSurveyViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/12/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class CreateSurveyViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var rewardtypelabel: UITextField!
    var ref: FIRDatabaseReference?
    
    var counter = 0
    
    var imageurls = [String]()
    
    var todaysdate = Date()
    let dateFormatter = DateFormatter()
    var todaysdatereadableformat = ""
    var enddatereadableformat = ""
    var surveytype = ""
    
    @IBAction func tapFeedback(_ sender: Any) {
        
        feedback.setImage(UIImage(named: "Feedback"), for: .normal)
        
        surveytype = "Feedback"
        
        
    }
    @IBOutlet weak var feedback: UIButton!
    @IBAction func tapSatisfaction(_ sender: Any) {
        
        satisfaction.setImage(UIImage(named: "SatisfactionPressed"), for: .normal)
        
        surveytype = "Satisfaction"
        
    }
    @IBOutlet weak var satisfaction: UIButton!
    @IBAction func tapShares(_ sender: Any) {
        
        shares.setImage(UIImage(named: "SharesPressed"), for: .normal)
        
        surveytype = "Shares"
    }
    @IBOutlet weak var shares: UIButton!
    @IBOutlet weak var expirationdatelabel: UITextField!
    @IBOutlet weak var dealimage: UIImageView!
    @IBOutlet weak var logoimage: UIImageView!

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            logoimage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func uploadLogo(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }

        
    @IBOutlet weak var tapcreatesurvey: UIButton!
    @IBOutlet weak var enddate: UITextField!
    @IBOutlet weak var productname: UITextField!
    @IBOutlet weak var originalprice: UITextField!
    @IBOutlet weak var companyname: UITextField!
    @IBOutlet weak var newprice: UITextField!

    
    
    @IBAction func tapCreateSurvey(_ sender: Any) {
        
        counter += 1
        
        let storage = FIRStorage.storage()
        
        let storageRef = storage.reference()
        
        var logoimagedata = Data()
        
        logoimagedata = UIImageJPEGRepresentation(self.logoimage.image!, 0.8)!
        
        // set upload path
        
        let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("logoimage\(counter)")"
        
        let metaData = FIRStorageMetadata()
        
        metaData.contentType = "image/jpg"
        
        storageRef.child(filePath).put(logoimagedata, metadata: metaData){(metaData,error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                
                return
                
            } else {
                
                // store download url
                let logodownloadURL = metaData!.downloadURL()!.absoluteString
                
                
                // store download url at database
                
                self.todaysdate = Date()
                
                self.dateFormatter.dateFormat = "MM/dd/yy"
                
                self.todaysdatereadableformat = self.dateFormatter.string(from: self.todaysdate)
                
                let intenddate = Int(self.enddate.text!)
                
                let finaldate = Calendar.current.date(byAdding: .day, value: intenddate!, to: self.todaysdate)
                
                self.enddatereadableformat = self.dateFormatter.string(from: finaldate!)
                
                let companynametext = self.companyname.text!
                let productnametext = self.productname.text!
                let originalpricetext = self.originalprice.text!
                let newpricetext = self.newprice.text!
                let rewardtypetext = self.rewardtypelabel.text!
                let expirationdatetext = self.expirationdatelabel.text!
                
                let key = self.ref?.child("Surveys").childByAutoId().key
                
                self.ref?.child("Surveys").childByAutoId().setValue(["CompanyName" : "\(companynametext)", "LaunchDate" : "\(self.todaysdatereadableformat)", "EndDate" : "\(self.enddatereadableformat)", "SurveyType" : "\(self.surveytype)", "ProductName" : "\(productnametext)", "OriginalPrice" : "\(originalpricetext)", "NewPrice" : "\(newpricetext)", "CompletedStatus" : "Incomplete", "ActiveStatus" : "Active", "LogoImage" : "\(logodownloadURL)", "RewardType" : "\(rewardtypetext)", "ExpirationDate" : "\(expirationdatetext)"])
                
                
            }
            
        
            
            
        }
    }
    
    
  
    
  
    override func viewDidLoad() {
        
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        
        let storage = FIRStorage.storage()
        
        let storageRef = storage.reference()
        
        

        
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
