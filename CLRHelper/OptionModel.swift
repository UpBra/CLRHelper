//
//  OptionModel.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


enum InputMode: String {
    case unknown = ""
    case json = "json"
    case clr = "clr"
}


class OptionModel {

    // MARK: - Properties

    var title: String?
    var prefix: String?
    var inputPath: String?
    var outputDir: String?
    var generateSwift: Bool = false
    var generateJava: Bool = false


    // MARK: - Public

    func colorsContainer() -> ColorsContainer? {
        guard let title = title else { printHelp("Missing -t title parameter") }
        guard let prefix = prefix else { printHelp("Missing -p prefix parameter") }
        guard let inputPath = inputPath else { printHelp("Missing -i input path parameter") }

        var container: ColorsContainer?

        switch mode {
        case .json:
            container = ColorsContainer(title: title, prefix: prefix, jsonPath: inputPath)

        case .clr:
            container = ColorsContainer(title: title, prefix: prefix, clrPath: inputPath)

        case .unknown:
            break
        }
        
        return container
    }
}
