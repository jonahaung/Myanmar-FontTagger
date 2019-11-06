//
//  TaggedFont.swift
//  Myanmar FontTagger
//
//  Created by Aung Ko Min on 6/11/19.
//  Copyright © 2019 Aung Ko Min. All rights reserved.
//

import UIKit

enum FontType {
    
    case ZawGyi, UniCode, Other
    
    var font: UIFont {
        switch self {
        case .UniCode:
            return UIFont.uniFont
        case .ZawGyi:
            return UIFont.zawGyiFont
        case .Other:
            return UIFont.otherFont
        }
    }
    
    var name: String {
        switch self {
        case .UniCode:
            return "Uni"
        case .ZawGyi:
            return "ZawGyi"
        case .Other:
            return "English"
        }
    }

}
