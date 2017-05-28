//
//  ColorItem.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class ColorItem {

    // MARK: - Properties

    let name: String
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat


    // MARK: - Initialization

    init?(json: JSONObject) {
        guard let name = json[Constant.JSONKey.Name] as? String else { print("Missing name in json object"); return nil }
        guard let red = json[Constant.JSONKey.Red] as? CGFloat else { print("Missing red value in json object"); return nil }
        guard let green = json[Constant.JSONKey.Green] as? CGFloat else { print("Missing green value in json object"); return nil }
        guard let blue = json[Constant.JSONKey.Blue] as? CGFloat else { print("Missing blue value in json object"); return nil }
        guard let alpha = json[Constant.JSONKey.Alpha] as? CGFloat else { print("Missing alpha value in json object"); return nil }

        self.name = name
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    init?(name: String, color: NSColor) {
        self.name = name
        self.red = color.literalRedComponent
        self.green = color.literalGreenComponent
        self.blue = color.literalBlueComponent
        self.alpha = color.alphaComponent
    }


    // MARK: - Public

    func caseName(prefix: String) -> String {
        let camelCaseName = name.removing(prefix).camelCaseString
        return camelCaseName
    }
}


// MARK: - <NSColorProvider>

extension ColorItem: NSColorProvider {

    func color() -> NSColor {
        let value = NSColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
        return value
    }
}


// MARK: - <JSONRepresentable>

extension ColorItem: JSONRepresentable {

    func jsonRepresentation() -> JSONObject {
        var json = JSONObject()

        json[Constant.JSONKey.Name] = name
        json[Constant.JSONKey.Red] = Int(red)
        json[Constant.JSONKey.Green] = Int(green)
        json[Constant.JSONKey.Blue] = Int(blue)
        json[Constant.JSONKey.Alpha] = alpha

        return json
    }
}


// MARK: - Constants

extension ColorItem {

    fileprivate struct Constant {

        struct JSONKey {
            static let Name = "n"
            static let Red = "r"
            static let Blue = "b"
            static let Green = "g"
            static let Alpha = "a"
        }
    }
}
