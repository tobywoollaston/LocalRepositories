//
//  LocalRepository.swift
//
//
//  Created by Toby Woollaston on 22/10/2023.
//

import Foundation
import Dependencies

class LocalRepository<T: RepositoryElement>: Repository {
    private let fileName: String
    
    @Dependency(\.fileProvider) var fileProvider
    @Dependency(\.jsonParser) var jsonParser
    
    init(_ fileName: String) {
        self.fileName = fileName
    }
    
    func save(_ element: T) async throws {
        var database = loadDatabase()
        database[element.id] = element
        try save(database)
    }
    
    func getAll() async throws -> [T] {
        let database = loadDatabase()
        return Array(database.values)
    }
    
    func getBy(id: String) async throws -> T {
        let database = loadDatabase()
        if let element = database[id] {
            return element
        } else {
            throw RepositoryError.notFound
        }
    }
    
    func delete(id: String) async throws {
        var database = loadDatabase()
        database.removeValue(forKey: id)
        try save(database)
    }
    
    func clearLocalRepository() throws {
        let database = [String: T]()
        try save(database)
    }
    
    private func save(_ database: [String: T]) throws {
        let contents = try jsonParser.encode(database)
        try fileProvider.save(contents, to: fileName)
    }
    
    private func loadDatabase() -> [String: T] {
        do {
            let contents = try fileProvider.read(fileName)
            return try jsonParser.decode(contents)
        } catch FileProviderError.doesNotExist {
            // we're fine
            return [:]
        } catch {
            // not as fine
        }
        return [:]
    }
}
