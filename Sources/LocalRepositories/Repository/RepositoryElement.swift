//
//  RepositoryElement.swift
//
//
//  Created by Toby Woollaston on 22/10/2023.
//

import Foundation

public protocol RepositoryElement: Identifiable, Codable, Equatable {
    var id: String { get }
}
