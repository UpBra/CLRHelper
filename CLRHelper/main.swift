//
//  main.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


var mode = InputMode.unknown
let options = OptionModel()

while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, "m:t:p:i:o:sj"), option != -1 {

    let scalar = UnicodeScalar(CUnsignedChar(option))

    switch scalar {
    case "m":
        mode = InputMode(rawValue: String(cString: optarg)) ?? .unknown

    case "t":
        options.title = String(cString: optarg)

    case "p":
        options.prefix = String(cString: optarg)

    case "i":
        options.inputPath = String(cString: optarg)

    case "o":
        options.outputDir = String(cString: optarg)

    case "s":
        options.generateSwift = true

    case "j":
        options.generateJava = true

    default:
        break
    }
}

switch mode {
case .json:
    guard let handler = JSONInputHandler(options: options) else { exit(EXIT_FAILURE) }
    handler.execute()

case .clr:
    guard let handler = CLRInputHandler(options: options) else { exit(EXIT_FAILURE) }
    handler.execute()

default:
    printHelp()
}
