//
//  XCTAssert+Helpers.swift
//  
//
//  Created by Toby Woollaston on 03/11/2023.
//

import XCTest

func XCTAssertThrowsErrorAsync<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTFail(message())
    } catch {
        errorHandler(error)
    }
}

func XCTAssertEquivalent<T>(
    _ result: [T], _ expected: [T],
    _ message: @autoclosure () -> String = ""
) where T : Equatable {
    expected.forEach {
        if !result.contains($0) {
            XCTFail(message())
        }
    }
}
