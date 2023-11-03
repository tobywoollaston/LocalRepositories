//
//  FileProvider.swift
//
//
//  Created by Toby Woollaston on 22/10/2023.
//

import Foundation
import Spyable

@Spyable
protocol FileProvider {
    func read(_ fileName: String) throws -> String
    func save(_ content: String, to fileName: String) throws
}
