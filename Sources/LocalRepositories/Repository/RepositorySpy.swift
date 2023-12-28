//
//  RepositorySpy.swift
//
//
//  Created by Toby Woollaston on 28/12/2023.
//

import Foundation

public class RepositorySpy<T: RepositoryElement>: Repository {
    var saveCallsCount = 0
    var saveCalled: Bool {
        return saveCallsCount > 0
    }
    var saveReceivedData: T?
    var saveReceivedInvocations: [T] = []
    var saveThrowableError: Error?
    var saveClosure: ((T) throws -> Void)?
    public func save(_ element: T) async throws {
        saveCallsCount += 1
        saveReceivedData = (element)
        saveReceivedInvocations.append((element))
        if let saveThrowableError {
            throw saveThrowableError
        }
        if saveClosure != nil {
            try saveClosure!(element)
        }
    }
    
    var getAllCallsCount = 0
    var getAllCalled: Bool {
        return getAllCallsCount > 0
    }
    var getAllThrowableError: Error?
    var getAllReturnValue: [T]?
    var getAllClosure: (() throws -> [T])?
    public func getAll() async throws -> [T] {
        getAllCallsCount += 1
        if let getAllThrowableError {
            throw getAllThrowableError
        }
        if getAllClosure != nil {
            return try getAllClosure!()
        } else {
            return getAllReturnValue!
        }
    }
    
    var getByCallsCount = 0
    var getByCalled: Bool {
        return getByCallsCount > 0
    }
    var getByReceivedData: String?
    var getByReceivedInvocations: [String] = []
    var getByThrowableError: Error?
    var getByReturnValue: Any!
    var getByClosure: ((String) throws -> Any)?
    public func getBy(id: String) async throws -> T {
        getByCallsCount += 1
        getByReceivedData = (id)
        getByReceivedInvocations.append((id))
        if let getByThrowableError {
            throw getByThrowableError
        }
        if getByClosure != nil {
            return try getByClosure!(id) as! T
        } else {
            return getByReturnValue as! T
        }
    }
    
    var deleteCallsCount = 0
    var deleteCalled: Bool {
        return deleteCallsCount > 0
    }
    var deleteReceivedData: String?
    var deleteReceivedInvocations: [String] = []
    var deleteThrowableError: Error?
    var deleteClosure: ((String) throws -> Void)?
    public func delete(id: String) async throws {
        deleteCallsCount += 1
        deleteReceivedData = (id)
        deleteReceivedInvocations.append((id))
        if let deleteThrowableError {
            throw deleteThrowableError
        }
        if deleteClosure != nil {
            try deleteClosure!(id)
        }
    }
}
