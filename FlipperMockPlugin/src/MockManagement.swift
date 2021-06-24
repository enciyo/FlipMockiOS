//
//  MockManagement.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation

internal class MockManagement {
    
    private init(){}
    
    /**
     MockPluginImp, FlipMockUrlProtocol
    */
    static let shared = MockManagement()
    
    private let dispatchQueue = DispatchQueue(label: FlipMock.PLUGIN_ID)
    private(set) var currentList : [Mock] = []
    private(set) var config :Config = Config()
    
    @discardableResult func setConfig(config:Config) -> Bool {
        dispatchQueue.sync {
            self.config = config
        }
        return true
    }
    
    @discardableResult func addAll(mock:[Mock]) -> Bool {
        dispatchQueue.sync {
            self.currentList.removeAll()
            self.currentList += mock
        }
        return true
    }

    @discardableResult func push(mock:Mock) throws -> Bool {
        var isSuccess: Bool = false
        dispatchQueue.sync {
            if findEqualMock(mock) == nil {
                self.currentList.append(mock)
                isSuccess = true
            }
        }
        return try check(isSuccess,"Mock uniqueId: \(mock.uniqueId) is exist! The same mock cannot be added.")
    }
    
    @discardableResult func update(mock:Mock) throws -> Bool {
        var isSuccess: Bool = false
        dispatchQueue.sync {
            if let existIndex  = self.findIndexOfMock(mock) {
                self.currentList[existIndex] = mock
                isSuccess = true
            }
        }
        return try check(isSuccess,"Mock uniqueId: \(mock.uniqueId) is not exist! Mock could not be updated!")
    }
    
    @discardableResult func remove(mock:Mock) throws -> Bool {
        var isSuccess: Bool = false
        dispatchQueue.sync {
            if let existIndex  = self.findIndexOfMock(mock) {
                self.currentList.remove(at: existIndex)
                isSuccess = true
            }
        }
        return try check(isSuccess,"Mock uniqueId: \(mock.uniqueId) is not exist! Mock could not be removed!")
    }
    
    func clear(){
        currentList.removeAll()
    }
    
    func findEqualMock(_ outMock:Mock) -> Int?{
        return self.currentList.firstIndex {item in
            item.isSameMock(outMock: outMock) || item.isSameEndpoint(outMock:outMock)
        }
    }

    func findMockOrNull(_ outMock : Mock) -> Mock? {
        return self.currentList.first { item in
            item.isSameMock(outMock: outMock)
        }
    }
    
    func findIndexOfMock(_ outMock:Mock) -> Int?{
        return self.currentList.firstIndex { item in
            item.isSameEndpoint(outMock: outMock)
        }
    }
    
    
    func check(_ isSuccess:Bool,_ failedMessage:String) throws -> Bool  {
        if !isSuccess  {
            throw Exceptions.IllegalStateException(message: failedMessage)
        }
        return isSuccess
    }
    
}

