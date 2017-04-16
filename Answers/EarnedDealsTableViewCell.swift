//
//  EarnedDealsTableViewCell.swift
//  Answers
//
//  Created by Alek Matthiessen on 4/11/17.
//  Copyright © 2017 AA Tech. All rights reserved.
//

import UIKit

class EarnedDealsTableViewCell: UITableViewCell {

    @IBOutlet weak var productnamelabel: UILabel!
    @IBOutlet weak var originalprice: UILabel!
    @IBOutlet weak var companyname: UILabel!
    @IBOutlet weak var expirationdate: UILabel!
    @IBOutlet weak var completiondate: UILabel!
    @IBOutlet weak var newprice: UILabel!
    @IBOutlet weak var companylogo: UIImageView!
    @IBOutlet weak var savings: UILabel!
    
    @IBOutlet weak var tapredeem: UIButton!
    @IBAction func tapRedeem(_ sender: Any) {
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
