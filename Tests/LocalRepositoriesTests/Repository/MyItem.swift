//
//  MyItem.swift
//  
//
//  Created by Toby Woollaston on 03/11/2023.
//

import Foundation
@testable import LocalRepositories

class MyItem: RepositoryElement {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static func == (lhs: MyItem, rhs: MyItem) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
    }
    
    public var description: String { return "{id: \(id), name: \(name)}" }
}
