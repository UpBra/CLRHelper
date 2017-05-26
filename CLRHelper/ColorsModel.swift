//
//  ColorsModel.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class ColorsModel {

    // MARK: - Properties

    private(set) var title: String
    private(set) var colors = [ColorItem]()
    private var list: NSColorList


    // MARK: - Initialization

    init?(mode: InputMode, title: String, inputPath: String) {
        guard let list = ColorsModel.generateNSColorList(mode: mode, title: title, inputPath: inputPath) else { return nil }

        self.title = title
        self.list = list

        generateColors()
    }


    // MARK: - Public

    func saveOutput(toDir path: String, generateSwift: Bool = false, generateJava: Bool = false) throws {
        switch mode {
        case .json:
            try saveCLRFile(toDir: path)

        case .clr:
            try saveJSONFile(toDir: path)

        default:
            break
        }

        if generateSwift {
            try saveSwiftFile(toDir: path)
        }

        if generateJava {
            try saveJavaFile(toDir: path)
        }
    }


    // MARK: - Private

    private static func generateNSColorList(mode: InputMode, title: String, inputPath: String) -> NSColorList? {
        var list: NSColorList?

        switch mode {
        case .json:
            list = NSColorList(jsonFile: inputPath)

        case .clr:
            list = NSColorList(name: title, fromFile: inputPath)

        default:
            break
        }

        return list
    }

    private func generateColors() {
        for key in list.allKeys {
            guard let color = list.color(withKey: key) else { continue }
            guard let item = ColorItem(title: key, color: color) else { continue }

            colors.append(item)
        }
    }

    private func saveJSONFile(toDir path: String) throws {
        var jsonData = JSONObject()

        for color in colors {
            let item = color.jsonObject()
            jsonData[item.title] = item.data
        }

        let url = URL(fileURLWithPath: path).appendingPathComponent("\(title).json")

        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions.prettyPrinted)
            try data.write(to: url)
        } catch (let error) {
            throw error
        }
    }

    private func saveCLRFile(toDir path: String) throws {
        let url = URL(fileURLWithPath: path).appendingPathComponent("\(title).clr")

        try list.write(to: url)
    }

    private func saveSwiftFile(toDir path: String) throws {
        let url = URL(fileURLWithPath: path).appendingPathComponent("\(title).swift")

        SwiftCodeGenerator.write(list, toURL: url)
    }

    private func saveJavaFile(toDir path: String) throws {
        let url = URL(fileURLWithPath: path).appendingPathComponent("\(title).java")

        JavaCodeGenerator.write(list, toURL: url)
    }
}
