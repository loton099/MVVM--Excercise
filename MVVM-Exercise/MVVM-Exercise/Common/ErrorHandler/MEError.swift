//
//  MEError.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 04/02/21.
//

import Foundation
import Combine

public enum MEError: Error {
  case alert(title: String, message: String?, code: Int)
}

extension MEError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .alert(_, let message, _): return message?.localized
    }
  }
  
  public var title: String {
    switch self {
    case .alert(let title,_, _): return title.localized
      
    }
  }
  
  public var code: Int? {
    switch self {
    case .alert(_, _, let code): return code
      
    }
  }
}

extension MEError {
    static func unknownError() -> MEError {
        return MEError.alert(title: "something_wrong".localized, message: "try_again".localized, code: 0)
    }
    
    static func decodingError() -> MEError {
        return MEError.alert(title: "decoding_error".localized, message: "try_again".localized, code: 0)
    }
    
    static func netWorkError() -> MEError {
        return MEError.alert(title: "network_error".localized, message: "try_again".localized, code: 0)
    }
    
}


