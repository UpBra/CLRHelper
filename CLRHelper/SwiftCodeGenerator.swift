//
//  GSwiftCodeGenerator.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class SwiftCodeGenerator: CodeGenerator {

    static func write(_ list: NSColorList, toURL url: URL) {
        var template = Template.Swift

        var caseStrings = ""
        var colorModelStrings = ""

        for (index, key) in list.allKeys.enumerated() {
            guard let color = list.color(withKey: key) else { continue }

            let caseStatement = String(format: Template.Format.Case, key)
            let colorModelStatement = String(format: Template.Format.ColorModel, key, color.literalRedComponent, color.literalGreenComponent, color.literalBlueComponent, color.alphaComponent)

            let isLast = index == list.allKeys.count - 1

            isLast ? caseStrings.append(caseStatement) : caseStrings.appendLine(caseStatement)
            isLast ? colorModelStrings.append(colorModelStatement) : colorModelStrings.appendLine(colorModelStatement)
        }

        template = template.replacingOccurrences(of: Template.Key.CaseStatements, with: caseStrings)
        template = template.replacingOccurrences(of: Template.Key.ColorModels, with: colorModelStrings)

        do {
            let data = template.data(using: .utf8)
            try data?.write(to: url)
        } catch {}
    }
}


extension SwiftCodeGenerator {

    fileprivate struct Template {

        struct Key {
            static let CaseStatements = "__CASE_STATEMENTS__"
            static let ColorModels = "__COLOR_MODELS__"
        }

        struct Format {
            static let Case = "\tcase %@"
            static let ColorModel = "\t.%@ : (%.0f, %.0f, %.0f, %.1f)"
        }

        static let Swift: String = [
            "//",
            "// JSON Generated Colors",
            "// Do not manually edit this file.",
            "//",
            "",
            "import Foundation",
            "import UIKit",
            "",
            "enum XYZColor {",
            Template.Key.CaseStatements,
            "}",
            "",
            "typealias ColorModel = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)",
            "",
            "let ColorMap: [XYZColorType:ColorModel] = [",
            Template.Key.ColorModels,
            "]",
            "",
            "extension UIColor {",
            "",
            "\tconvenience init(type: XYZColorType) {",
            "\t\tguard let model = ColorMap[type] else { self.init(white: 0.0, alpha: 1.0); return }",
            "",
            "\t\tself.init(red: model.red / 255.0, green: model.green / 255.0, blue: model.blue / 255.0, alpha: model.alpha)",
            "\t}",
            "}"
        ].joined(separator: "\n")
    }
}

