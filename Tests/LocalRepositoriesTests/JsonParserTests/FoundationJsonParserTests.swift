//
//  FoundationJsonParserTests.swift
//
//
//  Created by Toby Woollaston on 29/10/2023.
//

import XCTest
@testable import LocalRepositories

final class JsonParserTests: XCTestCase {
    
    let jsonParser = FoundationJsonParser()
    
    func test_decodeString() throws {
        let input = "\"hello there\""
        
        let result = try jsonParser.decode(input) as String
        
        XCTAssertEqual("hello there", result)
    }
    
    func test_decodeInt() throws {
        let input = "4"
        
        let result = try jsonParser.decode(input) as Int
        
        XCTAssertEqual(4, result)
    }
    
    func test_decodeDate() throws {
        let input = "\"2023-03-24T14:32:16\""
        
        let result = try jsonParser.decode(input) as Date
        
        XCTAssertEqual(
            Date.from(year: 2023, month: 3, day: 24, hour: 14, minute: 32, second: 16), result)
    }
    
    func test_decodeStringArray() throws {
        let input = "[\"hello\", \"there\"]"
        
        let result = try jsonParser.decode(input) as [String]
        
        XCTAssertEqual(["hello", "there"], result)
    }
    
    func test_decodeIntArray() throws {
        let input = "[123, 8]"
        
        let result = try jsonParser.decode(input) as [Int]
        
        XCTAssertEqual([123, 8], result)
    }
    
    func test_decodeObject() throws {
        let expected = MyObject(id: "theId", name: "WhatsUPPPP", count: 43)
        let input = "{\"id\":\"theId\",\"name\":\"WhatsUPPPP\",\"count\":43}"
        
        let result = try jsonParser.decode(input) as MyObject
        
        XCTAssertEqual(expected, result)
    }
    
    func test_decodeObjectArray() throws {
        let expected = MyObject(id: "theId", name: "WhatsUPPPP", count: 43)
        let input =
            """
            [
                {\"id\":\"theId\",\"name\":\"WhatsUPPPP\",\"count\":43},
                {\"id\":\"theId\",\"name\":\"WhatsUPPPP\",\"count\":43}
            ]
            """
        
        let result = try jsonParser.decode(input) as [MyObject]
        
        XCTAssertEqual([expected, expected], result)
    }
    
    func test_decodeDictionary() throws {
        let expected: [String: String] = ["TheKey": "TheValue", "Key2": "Value2"]
        let input =
            """
            {
                \"TheKey\":\"TheValue\",
                \"Key2\":\"Value2\"
            }
            """
        
        let result = try jsonParser.decode(input) as [String: String]
        
        XCTAssertEqual(expected, result)
    }
    
    func test_encodeString() throws {
        let input = "Hello there"
        let expected = "\"Hello there\""
        
        let result = try jsonParser.encode(input)
        
        XCTAssertEqual(expected, result)
    }
    
    func test_encodeInt() throws {
        let input = 75357
        let expected = "75357"
        
        let result = try jsonParser.encode(input)
        
        XCTAssertEqual(expected, result)
    }
    
    func test_encodeDate() throws {
        let input = Date.from(year: 2022, month: 3, day: 12, hour: 1, minute: 32, second: 14)
        let expected = "\"2022-03-12T01:32:14\""
        
        let result = try jsonParser.encode(input)
        
        XCTAssertEqual(expected, result)
    }
    
    func test_encodeArrayOfStrings() throws {
        let input = ["hello", "there"]
        let expected = "[\"hello\",\"there\"]"
        
        let result = try jsonParser.encode(input)
        
        XCTAssertEqual(expected, result)
    }
    
    func test_encodeArrayOfInts() throws {
        let input = [2, 3]
        let expected = "[2,3]"
        
        let result = try jsonParser.encode(input)
        
        XCTAssertEqual(expected, result)
    }
    
    func test_encodeObject() throws {
        let input = MyObject(id: "theId", name: "theName", count: 56)
        let expectedParts = ["\"id\":\"theId\"","\"count\":56","\"name\":\"theName\""]
        
        let result = try jsonParser.encode(input)
        
        expectedParts.forEach { part in
            XCTAssertTrue(result.contains(part))
        }
    }
    
    func test_encodeArrayOfObject() throws {
        let input = MyObject(id: "theId", name: "theName", count: 56)
        let expectedParts = ["\"id\":\"theId\"","\"count\":56","\"name\":\"theName\""]
        
        let result = try jsonParser.encode([input, input])
        
        expectedParts.forEach { part in
            XCTAssertTrue(result.numberOfOccurrencesOf(string: part) == 2)
        }
    }
    
    func test_encodeDictionary() throws {
        let expected = [
            "{\"TheKey\":\"TheValue\",\"Key2\":\"Value2\"}",
            "{\"Key2\":\"Value2\",\"TheKey\":\"TheValue\"}"
        ]
        let input = ["TheKey": "TheValue", "Key2": "Value2"]

        let result = try jsonParser.encode(input)

        XCTAssertTrue(expected.contains(result))
    }

}

fileprivate struct MyObject: Codable, Equatable {
    let id: String
    let name: String
    let count: Int
}

fileprivate extension Date {
    static func from(
        year: Int,
        month: Int = 1,
        day: Int = 1,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0
    ) -> Date {
        let dateString = "\(year)-\(month)-\(day)T\(hour):\(minute):\(second)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: dateString) else {
            return Date(timeIntervalSince1970: 0)
        }
        
        return date
    }
}

fileprivate extension String {
    func numberOfOccurrencesOf(string: String) -> Int {
        return self.components(separatedBy:string).count - 1
    }
}
