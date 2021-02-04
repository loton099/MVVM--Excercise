//
//  UITableViewCell+Additions.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 03/02/21.
//

import UIKit

extension UITableViewCell {
  /// This identifier tells about the own class type
  class var identifier: String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}
