//
//  extensions.swift
//  Myanmar FontTagger
//
//  Created by Aung Ko Min on 6/11/19.
//  Copyright © 2019 Aung Ko Min. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let zawGyiFont: UIFont = {
        if let x = UIFont(name: "Zawgyi-One", size: 17) {
            return UIFontMetrics(forTextStyle: .body).scaledFont(for: x)
        }
        return UIFont.preferredFont(forTextStyle: .body)
    }()

    static let uniFont: UIFont = {
        if let x = UIFont(name: "Pyidaungsu", size: 17) {
            return UIFontMetrics(forTextStyle: .body).scaledFont(for: x)
        }
        return UIFont.preferredFont(forTextStyle: .body)
    }()
    
    static let otherFont = UIFont.preferredFont(forTextStyle: .body)
}

extension NSRegularExpression {
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        let first = self.rangeOfFirstMatch(in: string, options: [], range: range)
        return first.location != NSNotFound
    }
}

extension String {
    var isZawGyi: Bool {
        return FontsTagger.shared.isZawGyiFont(text: self)
    }
}
