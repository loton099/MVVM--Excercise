//
//  UserViewModel.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 03/02/21.
//

import Foundation
import Combine

class UserViewModel: BaseViewModel {
   //MARK: Properties
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)?
    var requestSucceeded: (() -> Void)?
    var requestEncounteredError: ((_ error: MEError?) -> Void)?
    var requestfavouriteSuceeded:((_ updatedData: User)-> Void)?
    
    private var disposables = Set<AnyCancellable>()
    var networkfecher: NetworkFetchable
    private lazy var users : [User] = []
    
    var itemCount: Int  {
        return self.users.count
    }
    
    func itemAt(_ index: Int) -> User {
        return self.users[index]
    }
    
    init(apiService: NetworkFetchable = NetworkFetcher()) {
        self.networkfecher = apiService
    }
    
    //MARK: Methods
    func fetchUsersDetails() {
        self.requestStatusChanged?(true)
        self.networkfecher.getUserDetails()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.requestStatusChanged?(false)
                switch completion {
                    case .finished:
                        debugPrint("Completed")
                  
                case .failure(let error ): debugPrint(" Error Occured \(error)")
                    self.requestEncounteredError?(error)
                }
            } receiveValue: { [weak self] users in
                guard let self = self else { return }
                self.users = users
                self.requestSucceeded?()
            }
            .store(in: &disposables)
    }
    
    
    // MARK: - set favorite method

    /// - Parameter favouritesInfo: This one is the  updated UserDeatils  which is yet to be  updated in the viewModel Details
    /// - Returns: It return the index of the item so that it can be  changed in ViewController
    
    
      func updateUserFavouritesByReturningIndex(favouritesInfo: User) -> Int? {
        if let index = self.users.firstIndex(where: { $0.id == favouritesInfo.id }) {
          self.users[index].favouriteStatus = favouritesInfo.favouriteStatus
          return index
        }
        return nil
      }
    
    
    
    /// This  method used for performing Favourite call API For Time being we wil not  perform any actual Api will just change favourite staus of that particular object
    /// - Parameter data: Data  is of type  User
    func performFavouriteWith(data: User) {
        // perform api call retrieve actual status
        var favoriteUser = data
        favoriteUser.favouriteStatus = !data.favouriteStatus
        self.requestfavouriteSuceeded?(favoriteUser)
        
    }
    
}

