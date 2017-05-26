//
//  GenerateCLR.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


extension NSColorList {

    convenience init?(jsonFile: String) {
        guard let data = FileManager.default.contents(atPath: jsonFile) else { return nil }

        let json: JSONObject

        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! JSONObject
        } catch (let error) {
            print(error)
            return nil
        }

        guard let title = json[Constant.JSONKey.Title] as? String else { return nil }
        guard let colors = json[Constant.JSONKey.Colors] as? JSONObject else { return nil }

        self.init(name: title)

        for (key, value) in colors {
            guard let value = value as? JSONObject else { continue }
            guard let item = ColorItem(title: key, json: value) else { continue }

            let color = item.color()
            setColor(color, forKey: key)
        }
    }
}


extension NSColorList {

    fileprivate struct Constant {

        struct JSONKey {
            static let Title = "title"
            static let Colors = "colors"
        }
    }
}
