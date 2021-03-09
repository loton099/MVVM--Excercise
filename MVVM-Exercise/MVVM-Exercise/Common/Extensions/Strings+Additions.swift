//
//  Strings+Additions.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 04/02/21.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    func localized(withComment comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}
