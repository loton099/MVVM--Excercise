//
//  UserDetailsViewModel.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 09/03/21.
//

import Foundation
struct UserDetailsViewModel {
    
    var setfavouriteAction:((_ updatedData: Displayable)-> Void)?
    var userDetails: Displayable
    init(userDetails: Displayable) {
        self.userDetails = userDetails
    }
    
    mutating func performfavourite(_ isfavourite: Bool) {
        self.userDetails.isfavourite  = isfavourite
        self.setfavouriteAction?(self.userDetails)
    }
    
}
