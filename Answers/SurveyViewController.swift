//
//  SurveyViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/10/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class SurveyViewController: UIViewController {
    
    var ref: FIRDatabaseReference?
    
    var survey = surveyIDs[surveyID]
    
    var surveytype = ""

    @IBOutlet weak var companynamelabel: UILabel!
    @IBOutlet weak var backgroundimageView: UIImageView!
    @IBOutlet weak var questionnumberimageView: UIImageView!
    @IBOutlet weak var tapescape: UIButton!
    @IBOutlet weak var response1: UIImageView!
    @IBOutlet weak var response2: UIImageView!
    @IBOutlet weak var response3: UIImageView!
    @IBOutlet weak var response4: UIImageView!
 
    @IBOutlet weak var questionlabel: UILabel!
    
    var frame1 = CGRect()
    var frame2 = CGRect()
    var frame3 = CGRect()
    var frame4 = CGRect()
    
    var questioncounterdic: [Int] = []
    
    func onewasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: frame1.origin.x*3 + translation.x, y: frame1.origin.y + translation.y)
        
//        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 3 + translation.y)
        
        let xFromCenter = label.center.x - frame1.origin.x*3
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        print (label.center.x)
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var responsenumber = Int()
            
            if label.center.x > 400 {
                
                
                // Value of Response
                
                responsenumber = 1
                
                // Count Elements In Dictionary To See How Many Questions Have Been Answered
                
                var questioncounterdiccount = questioncounterdic.count
                
                // Store Value of Response
                
                ref?.child("Surveys").child("\(survey)").child("Responses").child("Question \(questioncounterdiccount)").childByAutoId().setValue(["Response" : "\(responsenumber)"])
                
               
                
                // Add One New One To Variable For Questions Answered
                
                questioncounterdiccount += 1
                
                // Add New One To Dictionary
                self.questioncounterdic.append(questioncounterdiccount)
                
                self.updatequestion()
                
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)
            
            
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: frame1.origin.x*3 - 10, y: frame1.origin.y + 10)
            

        }
        
    }
    
    func twowasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: frame2.origin.x*3 + translation.x, y: frame2.origin.y + translation.y)
        
        let xFromCenter = label.center.x - frame2.origin.x*3
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        print (label.center.x)
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var responsenumber = Int()
            
            if label.center.x > 400 {
                
                responsenumber = 2
                
                var questioncounterdiccount = questioncounterdic.count
                
                ref?.child("Surveys").child("\(survey)").child("Responses").child("Question \(questioncounterdiccount)").childByAutoId().setValue(["Response" : "\(responsenumber)"])
                
                
                
                questioncounterdiccount += 1
                
                self.questioncounterdic.append(questioncounterdiccount)
                
                self.updatequestion()
                
            }
            
            
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)
            
            
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: frame2.origin.x*3 - 10, y: frame2.origin.y + 10)
            
        }
        
    }
    
    func threewasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: frame3.origin.x*3 + translation.x, y: frame4.origin.y + translation.y)
        
        let xFromCenter = label.center.x - frame3.origin.x*3
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        print (label.center.x)
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var responsenumber = Int()
            
            if label.center.x > 400 {
                
                responsenumber = 3
                
                var questioncounterdiccount = questioncounterdic.count
                
                ref?.child("Surveys").child("\(survey)").child("Responses").child("Question \(questioncounterdiccount)").childByAutoId().setValue(["Response" : "\(responsenumber)"])
                
                
                
                
                questioncounterdiccount += 1
                
                self.questioncounterdic.append(questioncounterdiccount)
                
                self.updatequestion()
                
            }
            
            
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)
            
            
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: frame3.origin.x*3 - 10, y: frame3.origin.y + 10)
            
        }
        
    }
    
    func fourwasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: frame4.origin.x*3 + translation.x, y: frame4.origin.y + translation.y)
        
        let xFromCenter = label.center.x - frame4.origin.x*3
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        print (label.center.x)
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            var responsenumber = Int()
            
            if label.center.x > 400 {
                
                responsenumber = 4
                
                var questioncounterdiccount = questioncounterdic.count
                
                ref?.child("Surveys").child("\(survey)").child("Responses").child("Question \(questioncounterdiccount)").childByAutoId().setValue(["Response" : "\(responsenumber)"])
                
                questioncounterdiccount += 1
                
                self.questioncounterdic.append(questioncounterdiccount)
                
                self.updatequestion()
                
            }
            
            
            
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1) // rotation.scaleBy(x: scale, y: scale) is now rotation.scaledBy(x: scale, y: scale)
            
            
            label.transform = stretchAndRotation
            
            label.center = CGPoint(x: frame4.origin.x*3 - 10, y: frame4.origin.y + 10)
            
        }
        
    }
    
    
    func createquestions() {
        
        // Depending On Type of Survey, Different Questions & Survey Length Are Populated Into Database
        
        if surveytype == "Shares" {
            
        } else {
            
            ref?.child("Surveys").child("\(survey)").child("Responses").child("Question 0").updateChildValues(["Text" : "How Likely Are You To Refer Us To A Friend"])
            
            ref?.child("Surveys").child("\(survey)").child("Responses").child("Question 1").updateChildValues(["Text" : "How much can you lift"])
            
            ref?.child("Surveys").child("\(survey)").child("Responses").child("Question 2").updateChildValues(["Text" : "How hot is Miranda Kerr"])
            
            ref?.child("Surveys").child("\(survey)").child("Responses").child("Question 3").updateChildValues(["Text" : "For Sure, For Sure"])
            
            
//            response1.image =
//            
//            response2.image =
//            
//            response3.image =
//            
//            response4.image =
            
        }
    }
    
    
    func updatequestion() {
        
        // Depending On Question Number, Differnet Questions Are Pulled Into App
        
        let questioncounterdict = questioncounterdic.count
        
        ref?.child("Surveys").child("\(survey)").child("Responses").child("Question \(questioncounterdict)").child("Text").observe(.value, with: { (snapshot) in
        
            let snap = snapshot.value as? String
            
            self.questionlabel.text = snap
            
        
        })
        
        // If No More Questions, End System & Store Completed Survey ID & Date Completed
        
        
        let todaysdate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let todaysdatereadableformat = dateFormatter.string(from: todaysdate)
        
        if questioncounterdict > 3 {
            
            self.performSegue(withIdentifier: "SurveyToRewards", sender:
                                    self)
            
            let user = FIRAuth.auth()?.currentUser
            
            if let user = user {

                let uid = user.uid

                ref?.child("Users").child(uid).child("CompletedSurveys").childByAutoId().setValue(["ID" : "\(survey)", "DateCompleted" : "\(todaysdatereadableformat)"])
                
            }


        }
        
        if questioncounterdict == 0 {
            
            questionnumberimageView.image = UIImage(named: "Question1")
            
            //            response1.image =
            //
            //            response2.image =
            //
            //            response3.image =
            //            
            //            response4.image =
            
        }
        
        if questioncounterdict == 1 {
            
            questionnumberimageView.image = UIImage(named: "Question2")
            
            //            response1.image =
            //
            //            response2.image =
            //
            //            response3.image =
            //            
            //            response4.image =

            
        }
        
        if questioncounterdict == 2 {
            
            questionnumberimageView.image = UIImage(named: "Question3")
            
            //            response1.image =
            //
            //            response2.image =
            //
            //            response3.image =
            //            
            //            response4.image =
            
        }
        
        if questioncounterdict == 3 {
            
            questionnumberimageView.image = UIImage(named: "Question4")
            
            //            response1.image =
            //
            //            response2.image =
            //
            //            response3.image =
            //            
            //            response4.image =

            
        }
        

    
        
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        frame1 = response1.frame
        frame2 = response2.frame
        frame3 = response3.frame
        frame4 = response4.frame
        
        questioncounterdic.removeAll()
        
        questionnumberimageView.image = UIImage(named: "Question1")
        
        ref = FIRDatabase.database().reference()
        
        let gestureone = UIPanGestureRecognizer(target: self, action: #selector(self.onewasDragged(gestureRecognizer:)))
        
        let gesturetwo = UIPanGestureRecognizer(target: self, action: #selector(self.twowasDragged(gestureRecognizer:)))
        
        let gesturethree = UIPanGestureRecognizer(target: self, action: #selector(self.threewasDragged(gestureRecognizer:)))
        
        let gesturefour = UIPanGestureRecognizer(target: self, action: #selector(self.fourwasDragged(gestureRecognizer:)))
        
        response1.isUserInteractionEnabled = true
        
        response2.isUserInteractionEnabled = true
        
        response3.isUserInteractionEnabled = true
        
        response4.isUserInteractionEnabled = true
        
        response1.addGestureRecognizer(gestureone)
        
        response2.addGestureRecognizer(gesturetwo)
        
        response3.addGestureRecognizer(gesturethree)
        
        response4.addGestureRecognizer(gesturefour)
        
        createquestions()
        
        updatequestion()
        
        ref?.child("Surveys").child("\(survey)").observe(.value, with: {(snapshot) in
         
            if let snapDict = snapshot.value as? [String:AnyObject]{
                
                for each in snapDict {
                    
                    if each.key == "CompanyName" {
                        
                        self.companynamelabel.text = each.value as! String
                    }
                }
            }
        })
        
        
        
        
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
