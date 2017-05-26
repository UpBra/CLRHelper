//
//  ColorItem.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class ColorItem {

    let title: String
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat

    init?(title: String, json: JSONObject) {
        guard let red = json[Constant.JSONKey.Red] as? CGFloat else { return nil }
        guard let green = json[Constant.JSONKey.Green] as? CGFloat else { return nil }
        guard let blue = json[Constant.JSONKey.Blue] as? CGFloat else { return nil }
        guard let alpha = json[Constant.JSONKey.Alpha] as? CGFloat else { return nil }

        self.title = title
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    init?(title: String, color: NSColor) {
        self.title = title
        self.red = color.literalRedComponent
        self.green = color.literalGreenComponent
        self.blue = color.literalBlueComponent
        self.alpha = color.alphaComponent
    }

    func color() -> NSColor {
        let value = NSColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
        return value
    }

    func jsonObject() -> (title: String, data: JSONObject) {
        var json = JSONObject()

        json[Constant.JSONKey.Red] = red
        json[Constant.JSONKey.Green] = green
        json[Constant.JSONKey.Blue] = blue
        json[Constant.JSONKey.Alpha] = alpha

        return (title, json)
    }
}


extension ColorItem {

    fileprivate struct Constant {

        struct JSONKey {
            static let Red = "r"
            static let Blue = "b"
            static let Green = "g"
            static let Alpha = "alpha"
        }
    }
}
