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
}
