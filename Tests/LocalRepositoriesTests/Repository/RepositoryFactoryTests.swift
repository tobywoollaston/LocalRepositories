//
//  RepositoryFactoryTests.swift
//
//
//  Created by Toby Woollaston on 03/11/2023.
//

import XCTest
@testable import LocalRepositories

final class RepositoryFactoryTests: XCTestCase {
    func test_createRepositoryThroughFactory() async throws {
        let repo: any Repository<MyItem> = RepositoryFactory.createRepositoryFor("file")
        
        XCTAssertNotNil(repo)
    }
}
