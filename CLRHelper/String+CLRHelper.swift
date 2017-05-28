//
//  String+CLRHelper.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation


extension String {

    mutating func appendLine(_ line: String) {
        let adjusted = "\(line)\n"
        append(adjusted)
    }

    func removing(_ prefix: String) -> String {
        let string = replacingOccurrences(of: prefix, with: "")
        return string
    }

    var camelCaseString: String {
        let firstIndex = self.index(startIndex, offsetBy: 1)
        let composed = self.substring(to: firstIndex).lowercased() + self.substring(from: firstIndex)
        return composed
    }
}
