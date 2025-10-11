//
//  String+Localized.swift
//  FOTA
//
//  Created by Bluetrum on 2023/4/28.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
