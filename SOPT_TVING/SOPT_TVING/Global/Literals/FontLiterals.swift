//
//  FontLiterals.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/14.
//

import UIKit

extension UIFont {
    
    public enum FontName: String {
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case extraLight = "Pretendard-ExtraLight"
        
    }
    
    static func Font(_ type: FontName, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
