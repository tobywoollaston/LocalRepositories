//
//  FoundationJsonParser.swift
//  
//
//  Created by Toby Woollaston on 29/10/2023.
//

import Foundation

class FoundationJsonParser: JsonParser {
    let decoder: JSONDecoder!
    let encoder: JSONEncoder!
    
    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
    
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
    }
    
    func decode<T>(_ data: String) throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: Data(data.utf8))
    }
    
    func encode<T>(_ data: T) throws-> String where T : Encodable {
        let json = try encoder.encode(data)
        let string = String(data: json, encoding: .utf8)!
        
        return string
    }
}
