//
//  JsonParser.swift
//
//
//  Created by Toby Woollaston on 22/10/2023.
//

import Foundation

protocol JsonParser {
    func decode<T>(_ data: String) throws -> T where T : Decodable
    func encode<T>(_ data: T) throws -> String where T : Encodable
}
