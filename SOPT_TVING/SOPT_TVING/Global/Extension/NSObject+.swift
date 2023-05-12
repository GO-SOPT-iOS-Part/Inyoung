//
//  NSObject+.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/01.
//

import UIKit

extension NSObject {
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}
