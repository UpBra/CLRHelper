//
//  main.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit

enum InputMode: String {
    case unknown = ""
    case json = "json"
    case clr = "clr"
}

var mode = InputMode.unknown
var titleValue: String?
var inputValue: String?
var outputValue: String?
var generateSwift: Bool = false
var generateJava: Bool = false

while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, "m:t:i:o:"), option != -1 {

    let scalar = UnicodeScalar(CUnsignedChar(option))

    switch scalar {
    case "m":
        mode = InputMode(rawValue: String(cString: optarg)) ?? .unknown

    case "t":
        titleValue = String(cString: optarg)

    case "i":
        inputValue = String(cString: optarg)

    case "o":
        outputValue = String(cString: optarg)

    default:
        printHelp()
    }
}

guard mode != .unknown else {
    print("Missing -m Input mode is required")
    printHelp()
}

guard let title = titleValue else {
    print("Missing -t Title is required")
    printHelp()
}

guard let input = inputValue else {
    print("Missing -i Input is required")
    printHelp()
}

guard let output = outputValue else {
    print("Missing -o Output directory is required")
    printHelp()
}

var list: NSColorList?
let saveURL = URL(fileURLWithPath: output)

switch mode {
case .json:
    list = NSColorList(jsonFile: input)

case .clr:
    print("clr input not implemented")
    printHelp()

default:
    printHelp()
}

guard let list = list else { printHelp() }

do {
    let clrURL = saveURL.appendingPathComponent("title.clr")
    try list.write(to: clrURL)
} catch { }


let swiftURL = saveURL.appendingPathComponent("UIColor-Title.swift")
SwiftCodeGenerator.write(list, toURL: swiftURL)
