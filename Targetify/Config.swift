//
//  Config.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/17/22.
//

import UIKit
import Foundation

struct Config {
    static let isDebug: Bool = true //UIDevice.current.isSimulator
}

extension UIDevice {
    var isSimulator: Bool {
        #if IOS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
}
