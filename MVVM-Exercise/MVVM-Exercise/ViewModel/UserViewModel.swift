//
//  UserViewModel.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 03/02/21.
//

import Foundation
import Combine

class UserViewModel: BaseViewModel {
   
    var requestStatusChanged: ((_ inProgress: Bool) -> Void)?
    var requestSucceeded: (() -> Void)?
    var requestEncounteredError: ((_ error: MEError?) -> Void)?
    
    private var disposables = Set<AnyCancellable>()
    
    private lazy var users : [User] = []
    
    var itemCount: Int  {
        return self.users.count
    }
    
    func itemAt(_ index: Int) -> User {
        return self.users[index]
    }
    func fetchUsersDetails() {
        self.requestStatusChanged?(true)
        NetworkFetcher().getUserDetails()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.requestStatusChanged?(false)
                switch completion {
                    case .finished: debugPrint("Completion")
                  
                case .failure(let error ): debugPrint(" Error Occured \(error)")
                    self.requestEncounteredError?(error)
                }
            } receiveValue: { [weak self] users in
                debugPrint("Nodata")
                guard let self = self else { return }
                self.users = users
                self.requestSucceeded?()
            }
            .store(in: &disposables)
    }
    
    
        
    
    
}

