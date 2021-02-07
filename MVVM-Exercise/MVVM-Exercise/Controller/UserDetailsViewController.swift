//
//  UserDetailsViewController.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 05/02/21.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var comapanyLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var webSiteLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    var setfavouriteAction:((_ updatedData: Displayable)-> Void)?
    var userDetails: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        guard  let userdetails = userDetails  else {
            self.favouriteButton.isHidden = true
            return
        }
        self.userNameLabel.text = userdetails.userName
        self.fullNameLabel.text = userdetails.fullName
        self.phoneNumberLabel.text = userdetails.userPhoneNumber
        self.webSiteLabel.text = userdetails.userWebsite
        self.comapanyLabel.text = userdetails.userCompany
        self.addressLabel.text = userdetails.userAddress
        self.favouriteButton.isSelected = userdetails.isfavourite
        
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        self.favouriteButton.isSelected = !self.favouriteButton.isSelected
        self.userDetails?.isfavourite  = self.favouriteButton.isSelected
        self.setfavouriteAction?(self.userDetails!)
    }
    
}
