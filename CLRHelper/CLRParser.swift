//
//  CLRParser.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class CLRParser {

    static func generateColors(title: String, fromFile path: String?) -> [ColorItem]? {
        guard let list = NSColorList(name: title, fromFile: path) else { return nil }

        let colors = list.allKeys.flatMap { (key) -> ColorItem? in
            guard let color = list.color(withKey: key) else { return nil }

            let item = ColorItem(name: key, color: color)
            return item
        }

        return colors
    }
}
