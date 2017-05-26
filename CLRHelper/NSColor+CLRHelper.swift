//
//  NSColor+CLRHelper.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


extension NSColor {

    var literalRedComponent: CGFloat { return redComponent * 255.0 }
    var literalGreenComponent: CGFloat { return greenComponent * 255.0 }
    var literalBlueComponent: CGFloat { return blueComponent * 255.0 }
}
