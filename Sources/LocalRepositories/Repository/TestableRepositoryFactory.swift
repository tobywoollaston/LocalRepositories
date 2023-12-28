//
//  TestableRepositoryFactory.swift
//
//
//  Created by Toby Woollaston on 28/12/2023.
//

import Foundation

public class TestableRepositoryFactory {
    public static func createRepository<T: RepositoryElement>() -> RepositorySpy<T> {
        return RepositorySpy()
    }
}
