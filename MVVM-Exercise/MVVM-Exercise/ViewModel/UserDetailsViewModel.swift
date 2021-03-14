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
    
    /// This method is used for Performing  Favourite call API For Time being we wil not  perform any actual Api will just change favourite staus of that particular object
    /// - Parameter isfavourite: Its bool value indicates about favorite status
    mutating func performfavourite(_ isfavourite: Bool) {
        self.userDetails.isfavourite  = isfavourite
        self.setfavouriteAction?(self.userDetails)
    }
    
}
