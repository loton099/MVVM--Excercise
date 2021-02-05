//
//  UserListingTableViewCell.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 05/02/21.
//

import UIKit

class UserListingTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var mobileNoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var data: Displayable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(_ data: Displayable) {
        self.data = data
        self.companyLabel.text  = data.userCompany
        self.nameLabel.text = data.fullName
        self.mobileNoLabel.text = data.userPhoneNumber
        self.websiteLabel.text = data.userWebsite
        self.favouriteButton.isSelected = data.isfavourite ? true : false
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        
    }
    
}
