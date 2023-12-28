//
//  RepositorySpy.swift
//
//
//  Created by Toby Woollaston on 28/12/2023.
//

import Foundation

public class RepositorySpy<T: RepositoryElement>: Repository {
    public var saveCallsCount = 0
    public var saveCalled: Bool {
        return saveCallsCount > 0
    }
    public var saveReceivedData: T?
    public var saveReceivedInvocations: [T] = []
    public var saveThrowableError: Error?
    public var saveClosure: ((T) throws -> Void)?
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
    
    public var getAllCallsCount = 0
    public var getAllCalled: Bool {
        return getAllCallsCount > 0
    }
    public var getAllThrowableError: Error?
    public var getAllReturnValue: [T]?
    public var getAllClosure: (() throws -> [T])?
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
    
    public var getByCallsCount = 0
    public var getByCalled: Bool {
        return getByCallsCount > 0
    }
    public var getByReceivedData: String?
    public var getByReceivedInvocations: [String] = []
    public var getByThrowableError: Error?
    public var getByReturnValue: Any!
    public var getByClosure: ((String) throws -> Any)?
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
    
    public var deleteCallsCount = 0
    public var deleteCalled: Bool {
        return deleteCallsCount > 0
    }
    public var deleteReceivedData: String?
    public var deleteReceivedInvocations: [String] = []
    public var deleteThrowableError: Error?
    public var deleteClosure: ((String) throws -> Void)?
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
