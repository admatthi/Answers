//
//  ViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/10/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

var surveyIDs = [String]()
var surveytypes = [String]()

var surveyID = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func tapDeals(_ sender: Any) {
    }
   
    
    @IBOutlet weak var tapdeals: UIButton!
    @IBOutlet weak var tapSignOut: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
     var ref: FIRDatabaseReference?

    var dealimages = [UIImage]()
    var companynames = [String]()
    var newprices = [String]()
    var originalprices = [String]()
    var surveylaunched = [String]()
    var timetocompletes = [String]()
    var daysremaining = [String]()
    var productnames = [String]()
    var savingsdata = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Erase All Dictionary Values Each Time
        
        companynames.removeAll()
        newprices.removeAll()
        originalprices.removeAll()
        surveylaunched.removeAll()
        timetocompletes.removeAll()
        daysremaining.removeAll()
        
        ref = FIRDatabase.database().reference()
        
        let storage = FIRStorage.storage()
        
        // Get Today's Date
        
        let todaysdate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let todaysdatereadableformat = dateFormatter.string(from: todaysdate)
        
        
        // Update Survey Status's Depending On If Their End Dates's Have Passed From Today's Date

        ref?.child("Surveys").queryOrdered(byChild: "EndDate" ).queryEqual(toValue: "\(todaysdatereadableformat)").observe(.value, with: { (snapshot)
            
            in
            
            if var snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    if let id = each.key as? String {
                    
                     self.ref?.child("Surveys").child("\(id)").updateChildValues(["ActiveStatus" : "Inactive"])
                        
                    }
                    
                }
            }
        })
        
        // Pull All 'Active' Surveys & Update Dictionaries
        
        self.ref?.child("Surveys").queryOrdered(byChild: "ActiveStatus").queryEqual(toValue: "Active").observe(.value, with: { (snapshot) in
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    if let companyname = each.value["CompanyName"] as? String {
                        
                        self.companynames.append(companyname)
                    }
                    
                    if var surveytype = each.value["SurveyType"] as? String {
                        
                        if surveytype == "Shares" {
                            
                            let timetocomplete = "5 mins"
                        
                            self.timetocompletes.append(timetocomplete)
                        
//                        surveytypes.append(surveytype)
                            
                        } else {
                            
                            let timetocomplete = "2 mins"
                            
                            self.timetocompletes.append(timetocomplete)
                            
                            surveytypes.append(surveytype)
                            
                        }
                    }
                    
                    if var productname = each.value["ProductName"] as? String {
                        
                        self.productnames.append(productname)
                        
                    }
                    
                    if var originalprice = each.value["OriginalPrice"] as?
                        
                        String {
                        
                        self.originalprices.append(originalprice)
                        
                    }
                    
                    if var newprice = each.value["NewPrice"] as? String {
                        
                        self.newprices.append(newprice)

                    }
                    
                    if var enddate = each.value["EndDate"] as? String {
                        
                        self.daysremaining.append(enddate)
                    
                    }
                    
                    if var dealimage = each.value["LogoImage"] as? String {
                                                
                        let storage = FIRStorage.storage()
                        
                        print("\(dealimage)")
                        
                        storage.reference(forURL: "\(dealimage)").data(withMaxSize: 10*1024*1024, completion: { (data, error) in
                            
                            if data != nil {
                            
                            let dealphoto = UIImage(data: (data)!)
                            
                            self.dealimages.append(dealphoto!)
                            
                            print("Fuckdfsafadsfs \(self.dealimages)")
                            
                            self.tableView.reloadData()
                                
                            }

                                self.tableView.reloadData()
                        })
                        
                        print("Shit")
                        
                    }
                    
                    print("Balls")
                    
                    
                            
                        
                        
                    }
                    
                    
                    }
            
            
            self.tableView.reloadData()
            
            print(surveytypes)

        })
        
      
        
        // Get Active Survey ID's To Put Into Dictionary To Edit For Responses
        
        ref?.child("Surveys").queryOrdered(byChild: "ActiveStatus").queryEqual(toValue: "Active").observe(.value, with: { (snapshot) in
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    let ids = each.key
                    
                    surveyIDs.append(ids)
                    
                }
            }
            
        })
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dealimages.count > 0 {
        
        return dealimages.count
        
        } else {
            
            return 1
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DealsTableViewCell
        
        cell.taptakesurvey.setImage(UIImage(named: "Start Now"), for: .normal)
        
        if companynames.count > 0 {
            
        cell.companynamelabel.text = companynames[indexPath.row]
        cell.originalpricelabel.text = originalprices[indexPath.row]
        cell.newpricelabel.text = newprices[indexPath.row]
        cell.timetocompletelabel.text = timetocompletes[indexPath.row]
        cell.expirationdatelabel.text = "Ends On \(daysremaining[indexPath.row])"
            
//        cell.savingslabel.text = savingsdata[indexPath.row]
            
            if dealimages.count > 0 {
        
            cell.companylogo.image = dealimages[indexPath.row]
                
            }
        
            if productnames.count > 0 {
            
                cell.productnamelabel.text = productnames[indexPath.row]
                
            }
            
        }

        return cell
        
        
    }
    
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // Store Row Clicked On So We Can Pull That Element Within Survey ID's
        
        surveyID = indexPath.row
        
        performSegue(withIdentifier: "ToSurveyOne", sender: nil)
        
    }
    
    



}



