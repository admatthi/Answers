//
//  ThankYouViewController.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/15/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    var counter = 0
    
    func switchscreens() {
        
        self.performSegue(withIdentifier: "ThankYouToHome", sender: self)
    }
    
    func update() {
        
        counter += 1
        
        if counter >= 10 {
            
            switchscreens()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        counter = 0
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ThankYouViewController.update), userInfo: nil, repeats: true)

       
        
        
        

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
