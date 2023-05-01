//
//  StringLiterals.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/02.
//

import UIKit

struct StringLiterals {
    
    struct UserSetting {
        static let membership = "이용권"
        static let supportHistory = "1:1 문의내역"
        static let reservationNotification = "예약알림"
        static let userInfoEdit = "회원정보 수정"
        static let informationAgreement = "프로모션 정보 수신 동의"
        
        static var array: [String] = [membership,
                                      supportHistory,
                                      reservationNotification,
                                      userInfoEdit,
                                      informationAgreement]
    }
    
    struct AppSetting{
        static let notice = "공지사항"
        static let event = "이벤트"
        static let supportCenter = "고객센터"
        static let explore = "티빙 알아보기"
        
        static var array: [String] = [notice,
                                      event,
                                      supportCenter,
                                      explore]
    }
}


