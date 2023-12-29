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
        let fileUrl = fileUrl(for: fileName)
        if fileManager.fileExists(atPath: fileUrl.path) == false {
            throw FileProviderError.doesNotExist
        }
        
        let data = try Data(contentsOf: fileUrl)
        let output = String(decoding: data, as: UTF8.self)
        return output
    }
    
    func save(_ content: String, to fileName: String) throws {
        let fileUrl = fileUrl(for: fileName)
//        let data = content.data(using: String.Encoding.utf8)!
//        try data.write(to: fileUrl, options: .atomic)
        return try content.write(to: fileUrl, atomically: true, encoding: .utf8)
    }
    
    private func fileUrl(for fileName: String) -> URL {
        let filePath = documentsDirectoryUrl().appendingPathComponent(fileName)
        print(filePath.path)
//        if fileManager.fileExists(atPath: filePath.path) == false {
//            throw FileProviderError.doesNotExist
//        }
        return filePath
    }
    
    private func documentsDirectoryUrl() -> URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
