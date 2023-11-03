//
//  JsonParserSpy.swift
//
//
//  Created by Toby Woollaston on 01/11/2023.
//

import Foundation
@testable import LocalRepositories

class JsonParserSpy: JsonParser {
    var decodeCallsCount = 0
    var decodeCalled: Bool {
        return decodeCallsCount > 0
    }
    var decodeReceivedData: String?
    var decodeReceivedInvocations: [String] = []
    var decodeThrowableError: Error?
    var decodeReturnValue: Any!
    var decodeClosure: ((String) throws -> Any)?
        func decode<T>(_ data: String) throws -> T where T : Decodable {
        decodeCallsCount += 1
        decodeReceivedData = (data)
        decodeReceivedInvocations.append((data))
        if let decodeThrowableError {
            throw decodeThrowableError
        }
        if decodeClosure != nil {
            return try decodeClosure!(data) as! T
        } else {
            return decodeReturnValue as! T
        }
    }
    
    var encodeCallsCount = 0
    var encodeCalled: Bool {
        return encodeCallsCount > 0
    }
    var encodeReceivedData: Any!
    var encodeReceivedInvocations: [Any] = []
    var encodeThrowableError: Error?
    var encodeReturnValue: String?
    var encodeClosure: ((Any) throws -> String)?
        func encode<T>(_ data: T) throws -> String where T : Encodable {
        encodeCallsCount += 1
        encodeReceivedData = (data)
        encodeReceivedInvocations.append((data))
        if let encodeThrowableError {
            throw encodeThrowableError
        }
        if encodeClosure != nil {
            return try encodeClosure!(data)
        } else {
            return encodeReturnValue!
        }
    }
}
