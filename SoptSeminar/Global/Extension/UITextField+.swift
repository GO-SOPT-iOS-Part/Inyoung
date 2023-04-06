//
//  UITextField+.swift
//  SoptSeminar
//
//  Created by 김인영 on 2023/04/07.
//

import UIKit

extension UITextField {
    
    // 왼쪽에 여백 주기
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
