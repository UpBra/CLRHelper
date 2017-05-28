//
//  JSONParser.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation


class JSONParser {

    static func generateColors(fromPath path: String) -> [ColorItem]? {
        guard let data = FileManager.default.contents(atPath: path) else { return nil }

        let array: JSONArray

        do {
            array = try JSONSerialization.jsonObject(with: data, options: []) as! JSONArray
        } catch (let error) {
            print(error)
            return nil
        }

        let colors = array.flatMap { return ColorItem(json: $0) }

        return colors
    }
}
