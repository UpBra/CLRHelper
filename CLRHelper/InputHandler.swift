//
//  InputHandler.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class InputHandler {

    // MARK: - Properties

    let inputPath: String
    let outputDir: String
    let container: ColorsContainer

    private(set) var generateSwift: Bool = false
    private(set) var generateJava: Bool = false


    // MARK: - Initialization

    init?(options: OptionModel) {
        guard let inputPath = options.inputPath else { printHelp("Missing -i input path parameter") }
        guard let outputDir = options.outputDir else { printHelp("Missing -o outputDir is required") }
        guard let container = options.colorsContainer() else { printHelp("Unable to generate color list from input file") }

        self.inputPath = inputPath
        self.outputDir = outputDir
        self.container = container

        self.generateJava = options.generateJava
        self.generateSwift = options.generateSwift
    }


    // MARK: - Public

    open func execute() {
        if generateJava {
            JavaCodeGenerator.write(container, toDir: outputDir)
        }

        if generateSwift {
            SwiftCodeGenerator.write(container, toDir: outputDir)
        }
    }
}
