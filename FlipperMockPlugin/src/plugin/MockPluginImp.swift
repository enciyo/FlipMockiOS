//
//  MockPluginImp.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import FlipperKit

internal class MockPluginImp: NSObject,MockPlugin {
    

    private let RECEIVE_METHOD_ADD = "Add"
    private let RECEIVE_METHOD_REMOVE = "Remove"
    private let RECEIVE_METHOD_UPDATE = "Update"
    private let RECEIVE_METHOD_CONFIG = "Config"
    private let RECEIVE_METHOD_ADD_ALL = "AddAll"
    
    private lazy var mockManagement: MockManagement = {
        return MockManagement.shared
    }()
    
    private var connection: FlipperConnection? = nil
    
    func didConnect(_ connection: FlipperConnection!) {
        self.connection = connection
        connection.receiveSafe(RECEIVE_METHOD_ADD,onReceiveAdd())
        connection.receiveSafe(RECEIVE_METHOD_REMOVE,onReceiveRemove())
        connection.receiveSafe(RECEIVE_METHOD_UPDATE,onReceiveUpdate())
        connection.receiveSafe(RECEIVE_METHOD_CONFIG,onReceiveConfig())
        connection.receiveSafe(RECEIVE_METHOD_ADD_ALL,onReceiveAddAll())
    }
    
    func onReceiveConfig() -> ReceiveSafe {
        return {[weak self] params, responder in
            guard let self = self else { return }
            
            safeHandle {
                try self.mockManagement.setConfig(config: params.mapConfig())
            }
        }
    }
    
    func onReceiveAddAll() -> ReceiveSafe {
        return {[weak self] params, responder in
            guard let self = self else { return }
            
            safeHandle {
                let array = params["result"] as! NSArray
                let newArray = try array.map { item in
                    try (item as! [AnyHashable:Any]).mapMock()
                }
                self.mockManagement.addAll(mock: newArray)
            }
        }
    }

    
    func onReceiveAdd() -> ReceiveSafe {
        return {[weak self] params, responder in
            guard let self = self else { return }
            
            safeHandle {
                try self.mockManagement.push(mock: params.mapMock())
            }
        }
    }
    
    func onReceiveUpdate() -> ReceiveSafe {
        return {[weak self] params, responder in
            guard let self = self else { return }
            
            safeHandle {
                try self.mockManagement.update(mock: params.mapMock())
            }
        }
    }
    
    func onReceiveRemove() -> ReceiveSafe {
        return {[weak self] params, responder in
            guard let self = self else { return }
            
            safeHandle {
                try self.mockManagement.remove(mock: params.mapMock())
            }
        }
    }
        
    func didDisconnect() {
        mockManagement.clear()
        self.connection = nil
    }
    
    func runInBackground() -> Bool {
        return FlipMock.RUN_IN_BACKGROUND
    }
    
    func identifier() -> String! {
        return FlipMock.PLUGIN_ID
    }

}

