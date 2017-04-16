//
//  RewardsViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/10/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

var completedsurveys = [String]()

var completedsurveyID = 0

class RewardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: FIRDatabaseReference?

    @IBOutlet weak var tableView: UITableView!
    var images = [UIImage]()
    var companynames = [String]()
    var newprices = [String]()
    var originalprices = [String]()
    var surveylaunched = [String]()
    var completedates = [String]()
    var expirationdates = [String]()
    var productnames = [String]()
    var dealimages = [UIImage]()
    
    func johanscode() {
        
        self.ref?.child("Surveys").observe(.value, with: { (snapshot) in
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    var ids = each.key
                    
                    for value in completedsurveys {
                        
                        if value == ids {
                            
                            print ("Sucesss")
                        
                        if let companyname = each.value["CompanyName"] as? String {
                            
                            self.companynames.append(companyname)
                        }
                        
                        
                        if var originalprice = each.value["OriginalPrice"] as? String {
                            
                            self.originalprices.append(originalprice)
                            
                            let intoriginalprice = Int(originalprice)
                            
                        }
                        
                        if var newprice = each.value["NewPrice"] as? String {
                            
                            let intnewprice = Int(newprice)
                            
                            self.newprices.append(newprice)
                            
                        }
                        
                        if var expirationdate = each.value["ExpirationDate"] as? String {
                            
                            self.expirationdates.append(expirationdate)
                            
                        }
                            
                            if var productname = each.value["ProductName"] as? String {
                                
                                self.productnames.append(productname)

                                
                            }
                            
                            if var dealimage = each.value["LogoImage"] as? String {
                                
                                let storage = FIRStorage.storage()
                                
                                print("\(dealimage)")
                                
                                storage.reference(forURL: "\(dealimage)").data(withMaxSize: 10*1024*1024, completion: { (data, error) in
                                    
                                    let dealphoto = UIImage(data: data!)
                                    
                                    self.dealimages.append(dealphoto!)
                                    
                                    self.tableView.reloadData()
                                    
                                    print("FCUK")
                                    
                                })
                                
                                print("Shit")
                                
                                self.tableView.reloadData()
                            }

                        
                        
                    }
                    
                    }
                    
                }
                
                self.tableView.reloadData()
                
            }
            
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        completedsurveys.removeAll()
        images.removeAll()
        companynames.removeAll()
        newprices.removeAll()
        originalprices.removeAll()
        surveylaunched.removeAll()
        completedates.removeAll()
        expirationdates.removeAll()
        productnames.removeAll()
        dealimages.removeAll()
        
        ref = FIRDatabase.database().reference()
        
        let user = FIRAuth.auth()?.currentUser
        
        let uid = user!.uid
        
        // Get Completed Survey ID's Into Dictionary
        
        self.ref?.child("Users").child(uid).child("CompletedSurveys").queryOrdered(byChild: "DateCompleted").observe(.value, with: { (snapshot) in
            
            if let snapDict = snapshot.value as? [String:AnyObject] {
                
                for each in snapDict {
                    
                    if let completedsurveyid = each.value["ID"] as? String {
                        
                        completedsurveys.append(completedsurveyid)
                        
                    }
                    
                    if let completedate = each.value["DateCompleted"] as? String {
                        
                        self.completedates.append(completedate)
                        
                    }
                    
                    
                }
                
                print(completedsurveys)
                
                // Gotta reverse elements because they are from last to first in database and first to last in dictionary
                
                
                
            }
            
        })
        
        self.johanscode()
        
        completedsurveys.reverse()
       
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

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if companynames.count > 0 {
            
        return dealimages.count
            
        } else {
            
            return 1
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRewards", for: indexPath) as! EarnedDealsTableViewCell

        
        if companynames.count > 0 {
            
        cell.companyname.text = companynames[indexPath.row]
        
        cell.originalprice.text = originalprices[indexPath.row]
        
        cell.newprice.text = newprices[indexPath.row]
            
        cell.completiondate.text = "Completed On \(completedates[indexPath.row])"
            
        cell.expirationdate.text = "Expires On \(expirationdates[indexPath.row])"
            
        cell.productnamelabel.text = productnames[indexPath.row]
       
        cell.companylogo.image = dealimages[indexPath.row]
    
        }
        
        return cell
        
        
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        completedsurveyID = indexPath.row
        
        performSegue(withIdentifier: "RewardsToRedeem", sender: nil)
        
    }
    
 
    override func viewDidAppear(_ animated: Bool) {
            
        
    }
    
    
}
