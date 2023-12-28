//
//  File.swift
//  
//
//  Created by Toby Woollaston on 29/10/2023.
//

import Foundation
import Dependencies

private enum FileProviderKey: DependencyKey {
    static let liveValue: FileProvider = LocalFileProvider()
    static var testValue: FileProvider = FileProviderSpy()
}

extension DependencyValues {
    var fileProvider: FileProvider {
        get { self[FileProviderKey.self] }
        set { self[FileProviderKey.self] = newValue }
    }
}
