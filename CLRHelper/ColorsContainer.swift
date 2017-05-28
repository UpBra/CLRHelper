//
//  ColorsModel.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


struct ColorsContainer {

    // MARK: - Properties

    let title: String
    let prefix: String
    let colors: [ColorItem]


    // MARK: - Initialization

    init(title: String, prefix: String, colors: [ColorItem]) {
        self.title = title
        self.prefix = prefix
        self.colors = colors
    }

    init?(title: String, prefix: String, jsonPath path: String) {
        guard let colors = JSONParser.generateColors(fromPath: path) else { return nil }

        self.init(title: title, prefix: prefix, colors: colors)
    }

    init?(title: String, prefix: String, clrPath path: String) {
        guard let colors = CLRParser.generateColors(title: title, fromFile: path) else { return nil }

        self.init(title: title, prefix: prefix, colors: colors)
    }
}


// MARK: - <NSColorListProvider>

extension ColorsContainer: NSColorListProvider {

    func colorList() -> NSColorList {
        let list = NSColorList(name: title)

        colors.forEach { list.setColor($0.color(), forKey: $0.name) }

        return list
    }
}
