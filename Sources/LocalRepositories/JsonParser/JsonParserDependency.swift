//
//  File.swift
//  
//
//  Created by Toby Woollaston on 29/10/2023.
//

import Foundation
import Dependencies

private enum JsonParserKey: DependencyKey {
    static let liveValue: JsonParser = FoundationJsonParser()
    static var testValue: JsonParser = FoundationJsonParser()
}

extension DependencyValues {
    var jsonParser: JsonParser {
        get { self[JsonParserKey.self] }
        set { self[JsonParserKey.self] = newValue }
    }
}
