//
//  CLRInputHandler.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class CLRInputHandler: InputHandler {

    // MARK: - InputHandler Overrides

    override func execute() {
        var array = JSONArray()

        container.colors.forEach { array.append($0.jsonRepresentation()) }

        let saveURL = URL(fileURLWithPath: outputDir).appendingPathComponent("\(container.title).json")

        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            try data.write(to: saveURL)
        } catch (let error) {
            print(error)
        }
    }
}
