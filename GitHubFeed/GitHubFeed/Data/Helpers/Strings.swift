//
//  Strings.swift
//  GitHubFeed
//
//  Created by Grzegorz Surma on 17/10/2017.
//  Copyright © 2017 Grzegorz Surma. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    @discardableResult func bold(_ text: String, size: CGFloat = 15.0) -> NSMutableAttributedString {
        let boldString = NSMutableAttributedString(string: text,
            attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)])
        append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text: String, size: CGFloat = 15.0) -> NSMutableAttributedString {
        let normalString = NSMutableAttributedString(string: text,
            attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: size)])
        append(normalString)
        return self
    }
}

extension String {
    
    func newLineCharacter() -> String {
        return "\n"
    }
    
    func colonSeparator() -> String {
        return ": "
    }
}
