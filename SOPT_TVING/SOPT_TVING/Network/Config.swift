//
//  Config.swift
//  SOPT_TVING
//
//  Created by 김인영 on 2023/05/06.
//

import Foundation

enum Config {
    
    enum Keys {
        enum Plist {
            static let base_url = "BASE_URL"
            static let api_key = "API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    
    static let base_url: String = {
        guard let url = Config.infoDictionary[Keys.Plist.base_url] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration.")
        }
        return url
    }()
    
    static let api_key: String = {
        guard let key = Config.infoDictionary[Keys.Plist.api_key] as? String else {
            fatalError("API_key is not set in plist for this configuration.")
        }
        return key
    }()
}
