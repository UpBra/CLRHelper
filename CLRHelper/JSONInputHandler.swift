//
//  JSONInputHandler.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class JSONInputHandler: InputHandler {

    // MARK: - InputHandler Overrides

    override func execute() {
        super.execute()

        let list = container.colorList()
        let directory = URL(fileURLWithPath: outputDir)

        do {
            let clrURL = directory.appendingPathComponent("\(container.title).clr")
            try list.write(to: clrURL)
        } catch (let error) {
            print(error)
        }
    }
}
