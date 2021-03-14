//
//  Protocols.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 05/02/21.
//

import Foundation
import UIKit

//MARK: - Protocol to handle common callbacks of view models
protocol BaseViewModel: class {
    // Used to update the request started/ended status. can be usewd to update the activity indicator.
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)? { get set }
    // Used to inform about the error
    var requestEncounteredError: ((_ error: MEError?) -> Void)? { get set }
}
//MARK: - FavouriteSetable protocol is used for setting user as favourite
protocol FavouriteSetable {
    func updateFavourite(status: Bool, atIndex index: Int?)
}
//MARK: - Tappable protocol is used for requesting favourite user
protocol Tappable: class {
    func favouriteRequestedof(data: Displayable)
}
//MARK: Displayable protocol is used to handle userData
protocol Displayable {
    var userID: Int { get }
    var fullName: String { get }
    var userName: String { get }
    var userPhoneNumber: String { get }
    var userWebsite: String { get }
    var userCompany: String { get }
    var isfavourite: Bool { get set }
    var userAddress: String { get }
}

extension Displayable {
    var userID: Int {
        HeightConstants.annoymousID
    }
    var fullName: String {
        SpacingConstants.emptyString
    }
    var userName: String {
        SpacingConstants.emptyString
    }
    var userPhoneNumber: String {
        SpacingConstants.emptyString
    }
    var userWebsite: String {
        SpacingConstants.emptyString
    }
    var userCompany: String {
        SpacingConstants.emptyString
    }
    
    var isfavourite: Bool {
        get {
            return isfavourite
        }
        set {
            self.isfavourite = newValue
        }
    }
    
}

