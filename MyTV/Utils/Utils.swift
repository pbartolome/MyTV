//
//  Utils.swift
//  MyTV
//
//  Created by Pablo Bartolome on 2/26/17.
//  Copyright © 2017 PB. All rights reserved.
//

import UIKit

extension String {
    

    func decodingHTML() -> String {
        guard let data = data(using: .utf8) else {
            return self
        }
        do {
            let attributedOptions : [String: Any] = [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
            ]
            let attributed = try NSAttributedString(data: data, options: attributedOptions, documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }

    func removingMatches(pattern: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let newString = regex.stringByReplacingMatches(in: self, options: .reportCompletion , range: NSMakeRange(0, self.characters.count), withTemplate: "")
            return newString
        } catch {
            return self
        }
    }

}

