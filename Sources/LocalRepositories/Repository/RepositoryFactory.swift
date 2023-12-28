//
//  RepositoryFactory.swift
//
//
//  Created by Toby Woollaston on 22/10/2023.
//

import Foundation

public class RepositoryFactory {
    public static func createRepositoryFor<T: RepositoryElement>(_ fileName: String) -> any Repository<T> {
        return LocalRepository<T>(fileName)
    }
    public static func createTestableRepository<T: RepositoryElement>() -> RepositorySpy<T> {
        return RepositorySpy()
    }
}
