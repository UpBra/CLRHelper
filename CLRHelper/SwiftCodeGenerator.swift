//
//  GSwiftCodeGenerator.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation
import AppKit


class SwiftCodeGenerator: CodeGenerator {

    static func write(_ container: ColorsContainer, toDir directory: String) {
        var template = Template.Swift

        var caseStrings = ""
        var colorModelStrings = ""

        for (index, item) in container.colors.enumerated() {
            let camcelCaseName = item.caseName(prefix: container.prefix)
            let caseStatement = String(format: Template.Format.Case, camcelCaseName)
            let colorModelStatement = String(format: Template.Format.ColorModel, camcelCaseName, item.red, item.green, item.blue, item.alpha)

            let isLast = index == container.colors.count - 1

            isLast ? caseStrings.append(caseStatement) : caseStrings.appendLine(caseStatement)
            isLast ? colorModelStrings.append(colorModelStatement) : colorModelStrings.appendLine(colorModelStatement)
        }

        template = template.replacingOccurrences(of: Template.Key.Title, with: container.title)
        template = template.replacingOccurrences(of: Template.Key.CaseStatements, with: caseStrings)
        template = template.replacingOccurrences(of: Template.Key.ColorModels, with: colorModelStrings)

        let saveURL = URL(fileURLWithPath: directory).appendingPathComponent("UIColor+\(container.title).swift")

        do {
            let data = template.data(using: .utf8)
            try data?.write(to: saveURL)
        } catch {}
    }
}


// MARK: - Constants

extension SwiftCodeGenerator {

    fileprivate struct Template {

        struct Key {
            static let Title = "{TITLE}"
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
            "enum \(Template.Key.Title) {",
            Template.Key.CaseStatements,
            "}",
            "",
            "typealias ColorModel = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)",
            "",
            "let ColorMap: [\(Template.Key.Title):ColorModel] = [",
            Template.Key.ColorModels,
            "]",
            "",
            "extension UIColor {",
            "",
            "\tconvenience init(type: \(Template.Key.Title)) {",
            "\t\tguard let model = ColorMap[type] else { self.init(white: 0.0, alpha: 1.0); return }",
            "",
            "\t\tself.init(red: model.red / 255.0, green: model.green / 255.0, blue: model.blue / 255.0, alpha: model.alpha)",
            "\t}",
            "}"
        ].joined(separator: "\n")
    }
}

