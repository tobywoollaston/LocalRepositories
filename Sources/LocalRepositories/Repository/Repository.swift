//
//  Repository.swift
//
//
//  Created by Toby Woollaston on 22/10/2023.
//

import Foundation

public protocol Repository<RE> {
    associatedtype RE: RepositoryElement
    
    func save(_ element: RE) async throws
    func getAll() async throws -> [RE]
    func getBy(id: String) async throws -> RE
    func delete(id: String) async throws
    func clearLocalRepository() throws
}
