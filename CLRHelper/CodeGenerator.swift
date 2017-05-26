//
//  CodeGenerator.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


protocol CodeGenerator {
    static func write(_ list: NSColorList, toURL url: URL)
}
