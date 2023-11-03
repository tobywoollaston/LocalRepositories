//
//  LocalFileProvider.swift
//  
//
//  Created by Toby Woollaston on 29/10/2023.
//

import Foundation
import Dependencies

class LocalFileProvider: FileProvider {
    private let fileManager = FileManager()
    
    func read(_ fileName: String) throws -> String {
        let fileUrl = try fileUrl(for: fileName)
        let data = try Data(contentsOf: fileUrl)
        let output = String(decoding: data, as: UTF8.self)
        return output
    }
    
    func save(_ content: String, to fileName: String) throws {
        let fileUrl = try fileUrl(for: fileName)
        return try content.write(to: fileUrl, atomically: true, encoding: .utf8)
    }
    
    private func fileUrl(for fileName: String) throws -> URL {
        let filePath = documentsDirectoryUrl().appendingPathComponent(fileName)
        if fileManager.fileExists(atPath: filePath.path) == false {
            throw FileProviderError.doesNotExist
        }
        return filePath
    }
    
    private func documentsDirectoryUrl() -> URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
