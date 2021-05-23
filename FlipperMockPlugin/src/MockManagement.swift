//
//  MockManagement.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation

internal class MockManagement {
    
    private let dispatchQueue = DispatchQueue(label: FlipperMockNetworkPlugin.PLUGIN_ID)
    private var currentList : [Mock] = []
    
    private(set) var config :Config = Config()
    
    
    @discardableResult func setConfig(config:Config) -> Bool {
        dispatchQueue.sync {
            self.config = config
        }
        return true
    }
    
    @discardableResult func addAll(mock:[Mock]) -> Bool {
        dispatchQueue.sync {
            self.currentList += mock
        }
        return true
    }
    
    @discardableResult func push(mock:Mock) throws -> Bool {
        var isSuccess: Bool = true
        dispatchQueue.sync {
            let existIndex = self.currentList.firstIndex { item in
                item.isSameMock(outMock: mock) || item.isSameEndpoint(outMock: mock)
            }
            if existIndex != nil {
                isSuccess = false
            }
            self.currentList.append(mock)
        }
        return try check(isSuccess: isSuccess,failedMessage: "Mock uniqueId: \(mock.uniqueId) is exist! The same mock cannot be added.")
    }
    
    @discardableResult func update(mock:Mock) throws -> Bool {
        var isSuccess: Bool = true
        dispatchQueue.sync {
            let existIndex = self.findIndexOfFirstMock(mock: mock)
            if existIndex != nil {
                isSuccess = false
            }
            self.currentList[existIndex!] = mock
        }
        return try check(isSuccess: isSuccess,failedMessage: "Mock uniqueId: \(mock.uniqueId) is not exist! Mock could not be updated!")
    }
    
    @discardableResult func remove(mock:Mock) throws -> Bool {
        var isSuccess: Bool = true
        dispatchQueue.sync {
            let existIndex = self.findIndexOfFirstMock(mock: mock)
            if existIndex == nil {
                isSuccess = false
            }
            self.currentList.remove(at: existIndex!)
        }
        return try check(isSuccess: isSuccess,failedMessage: "Mock uniqueId: \(mock.uniqueId) is not exist! Mock could not be removed!")
    }
    
    func clear(){
        currentList.removeAll()
    }
    

    func findFirstOrNullMock(requestMock : Mock) -> Mock? {
        let existIndex = self.currentList.firstIndex { item in
            item.isSameMock(outMock: requestMock)
        }
        return existIndex != nil ? currentList[existIndex!] : nil
    }
    
    func findIndexOfFirstMock(mock:Mock) -> Int?{
        let existIndex = self.currentList.firstIndex { item in
            item.isSameEndpoint(outMock: mock)
        }
        return existIndex
    }
    
    
    func check(isSuccess:Bool,failedMessage:String) throws -> Bool  {
        if isSuccess == false {
            throw Exceptions.IllegalStateException(message: failedMessage)
        }
        
        return isSuccess
    }
    
}

