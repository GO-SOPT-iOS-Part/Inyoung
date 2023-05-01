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
    }
    
    struct Icn {
        static let back = UIImage(named: "icn_back")
        static let close = UIImage(named: "icn_close")
        static let eyeClose = UIImage(named: "icn_eyeClose")
        static let eyeOpen = UIImage(named: "icn_eyeOpen")
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
}
