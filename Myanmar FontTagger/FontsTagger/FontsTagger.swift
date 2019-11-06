//
//  ZawGyiFontChecker.swift
//  mMsgr
//
//  Created by Aung Ko Min on 22/4/19.
//  Copyright © 2019 Aung Ko Min. All rights reserved.
//

import UIKit



extension String {
    
    var unicodedString: String {
        if let dataenc = self.data(using: .nonLossyASCII) {
            return String(data: dataenc, encoding: .utf8) ?? self
        }
        return self
    }
    var deUnicodedString: String {
        if let dataenc = self.data(using: .utf8) {
            return String(data: dataenc, encoding: .nonLossyASCII) ?? self
        }
        return self
    }
}

class FontsTagger {
    
    static var shared: FontsTagger {
        struct Singleton {
            static let instance = FontsTagger()
        }
        return Singleton.instance
    }
    
    private let myanmarPattern = "[\\u1000-\\u109f\\uaa60-\\uaa7f]+"
    private let khmarPattern = "[\\u1780–\\u17FF]+"
    private let unicodePattern: String = {
        return "[ဃငဆဇဈဉညဋဌဍဎဏဒဓနဘရဝဟဠအ]်|ျ[က-အ]ါ|ျ[ါ-း]|\\u103e|\\u103f|\\u1031[^\\u1000-\\u1021\\u103b\\u1040\\u106a\\u106b\\u107e-\\u1084\\u108f\\u1090]|\\u1031$|\\u1031[က-အ]\\u1032|\\u1025\\u102f|\\u103c\\u103d[\\u1000-\\u1001]|ည်း|ျင်း|င်|န်း|ျာ|စ်|န္တ[က-အ]"
    }()
    private let zawGyiPattern = String("\\s\\u1031| ေ[က-အ]်|[က-အ]း")
    
    private var cachedRegularExpressions: [String : NSRegularExpression] = [:]

    func isZawGyiFont(text: String) -> Bool {
        return tagFont(for: text) == .ZawGyi
    }
    
    func tagFont(for text: String) -> FontType {
        if let myanmar = regularExpression(for: myanmarPattern) {
            if myanmar.matches(text) {
                // is Myanmar Font
                if let unicode = regularExpression(for: unicodePattern) {
                    if unicode.matches(text) {
                        return .UniCode
                    } else {
                        return .ZawGyi
                    }
                } else { fatalError() }
            } else {
                return FontType.Other
            }
        } else { fatalError() }
    }
}

extension FontsTagger {
    
    private func regularExpression(for pattern: String) -> NSRegularExpression? {
        if let regex = cachedRegularExpressions[pattern] {
            return regex
        } else {
            do {
                let regx = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
                cachedRegularExpressions[pattern] = regx
                return regx
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
    }
    
}
