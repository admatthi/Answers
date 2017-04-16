//
//  DealsTableViewCell.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/10/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit

class DealsTableViewCell: UITableViewCell {

    @IBOutlet weak var companylogo: UIImageView!
    @IBOutlet weak var companynamelabel: UILabel!
    @IBOutlet weak var timetocompletelabel: UILabel!
    @IBOutlet weak var originalpricelabel: UILabel!
    @IBOutlet weak var newpricelabel: UILabel!
    @IBOutlet weak var savingslabel: UILabel!
    @IBOutlet weak var productnamelabel: UILabel!
   
    @IBOutlet weak var taptakesurvey: UIButton!
    
    @IBAction func tapTakeSurvey(_ sender: Any) {
    }
    @IBOutlet weak var expirationdatelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
