//
//  ImageLiterals.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/04/14.
//

import UIKit

struct ImageLiterals {
    
    struct Logo {
        static let logoImage = UIImage(named: "tving_logo")
        static let logoImageWhite = UIImage(named: "tving_logo_white")
    }
    
    struct Icn {
        static let back = UIImage(named: "icn_back")
        static let close = UIImage(named: "icn_close")
        static let eyeClose = UIImage(named: "icn_eyeClose")
        static let eyeOpen = UIImage(named: "icn_eyeOpen")
        static let alarm = UIImage(named: "icon_alarm")
        static let setting = UIImage(named: "icon_setting")
        static let cash = UIImage(named: "icon_cash")
        static let ticket = UIImage(named: "icon_ticket")
    }
    
    struct TabBar {
        static let home = UIImage(systemName: "house")
        static let homeSelected = UIImage(systemName: "house.fill")
        static let upcoming = UIImage(systemName: "arrow.up.right.video")
        static let upcomingSelected = UIImage(systemName: "arrow.up.right.video.fill")
        static let search = UIImage(systemName: "magnifyingglass")
        static let record = UIImage(systemName: "clock.badge.checkmark")
        static let recrodSelected = UIImage(systemName: "clock.badge.checkmark.fill")
    }
    
    struct Sample {
        static let profileImage = UIImage(named: "profileImage1")
    }
}
