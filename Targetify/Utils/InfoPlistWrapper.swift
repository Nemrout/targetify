//
//  InfoPlistWrapper.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Foundation

@propertyWrapper
struct InfoPlistWrapper {
    
    enum Key: String {
        case newsApi = "NewsAPIKey"
    }
    
    let key: Key
    
    var wrappedValue: String? {
        Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
    }
}
