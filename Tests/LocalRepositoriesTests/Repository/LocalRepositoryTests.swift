//
//  LocalRepositoryTests.swift
//
//
//  Created by Toby Woollaston on 02/11/2023.
//

import XCTest
import Dependencies

@testable import LocalRepositories

final class LocalRepositoryTests: XCTestCase {
    private var repo: (any Repository<MyItem>)!
    private var fileProviderSpy: FileProviderSpy!
    private var jsonParserSpy: JsonParserSpy!
    private var fileName = "fileName.db"
    
    override func setUp() async throws {
        fileProviderSpy = FileProviderSpy()
        fileProviderSpy.readReturnValue = ""
        jsonParserSpy = JsonParserSpy()
        jsonParserSpy.decodeReturnValue = [String: MyItem]()
        jsonParserSpy.encodeReturnValue = ""
        
        repo = withDependencies {
            $0.fileProvider = fileProviderSpy
            $0.jsonParser = jsonParserSpy
        } operation: {
            LocalRepository<MyItem>(fileName)
        }
    }
    
    func test_save_shouldSaveItemToFile() async throws {
        let item = MyItem(id: "id", name: "item")
        
        try await repo.save(item)
        
        XCTAssertTrue(fileProviderSpy.readCalled)
        XCTAssertEqual(jsonParserSpy.encodeReceivedData as! [String: MyItem], [item.id: item])
        XCTAssertTrue(fileProviderSpy.saveToCalled)
    }
    
    func test_getAll_shouldReturnAllItems() async throws {
        let item1 = MyItem(id: "id1", name: "item1")
        let item2 = MyItem(id: "id2", name: "item2")
        jsonParserSpy.decodeReturnValue = [item1.id: item1, item2.id: item2]
        
        let result = try await repo.getAll()
        
        XCTAssertTrue(fileProviderSpy.readCalled)
        XCTAssertEquivalent(result, [item1, item2])
    }
    
    func test_getById_shouldReturnCorrectItem() async throws {
        let item = MyItem(id: "id", name: "item")
        jsonParserSpy.decodeReturnValue = [item.id: item]
        
        let result = try await repo.getBy(id: "id")
        
        XCTAssertTrue(fileProviderSpy.readCalled)
        XCTAssertEqual(result, item)
    }
    
    func test_getById_shouldThrowNotFoundIfElementDoesNotExist() async throws {
        await XCTAssertThrowsErrorAsync(try await repo.getBy(id: "id")) { err in
            XCTAssertEqual(err as! RepositoryError, RepositoryError.notFound)
        }
        XCTAssertTrue(fileProviderSpy.readCalled)
    }
    
    func test_deleteId_shouldDeleteCorrectItem() async throws {
        let item1 = MyItem(id: "id1", name: "item1")
        let item2 = MyItem(id: "id2", name: "item2")
        jsonParserSpy.decodeReturnValue = [item1.id: item1, item2.id: item2]
        
        try await repo.delete(id: "id1")
        
        XCTAssertTrue(fileProviderSpy.readCalled)
        XCTAssertEqual(jsonParserSpy.encodeReceivedData as! [String: MyItem], [item2.id: item2])
    }
    
    func test_clearLocalRepository_shouldClearAllItems() async throws {
        try repo.clearLocalRepository()
        
        XCTAssertEqual(jsonParserSpy.encodeReceivedData as! [String: MyItem], [:])
    }
}
