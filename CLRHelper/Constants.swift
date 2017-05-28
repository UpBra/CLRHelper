//
//  Constants.swift
//  Copyright © 2017 Gleesh. All rights reserved.
//

import Foundation


typealias JSONObject = [String:Any]
typealias JSONArray = [JSONObject]


func printHelp(_ message: String? = nil) -> Never {
    if let message = message {
        print(message)
    }

    print("help. i need somebody.")
    print("help. not just anybody.")

    exit(EXIT_FAILURE)
}
