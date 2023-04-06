//
//  UIViewController+.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/07.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
