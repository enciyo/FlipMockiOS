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
    
    
    let mockManagement: MockManagement = MockManagement()
    private var connection: FlipperConnection? = nil
    
    
    
    func didConnect(_ connection: FlipperConnection!) {
        self.connection = connection
        connection.receiveSafe(RECEIVE_METHOD_ADD,onReceiveAdd())
        connection.receiveSafe(RECEIVE_METHOD_REMOVE,onReceiveRemove())
        connection.receiveSafe(RECEIVE_METHOD_UPDATE,onReceiveUpdate())
        connection.receiveSafe(RECEIVE_METHOD_CONFIG,onReceiveConfig())
        
    }
    
    
    func onReceiveConfig() -> ReceiveSafe {
        return { params, responder in
            safeHandle {
                try self.mockManagement.setConfig(config: params.mapConfig())
            }
        }
    }
    
    
    func onReceiveAdd() -> ReceiveSafe {
        return { params, responder in
            safeHandle {
                try self.mockManagement.push(mock: params.mapMock())
            }
        }
    }
    
    func onReceiveUpdate() -> ReceiveSafe {
        return { params, responder in
            safeHandle {
                try self.mockManagement.update(mock: params.mapMock())
            }
        }
    }
    
    func onReceiveRemove() -> ReceiveSafe {
        return { params, responder in
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
        return FlipperMockNetworkPlugin.RUN_IN_BACKGROUND
    }
    
    func identifier() -> String! {
        return FlipperMockNetworkPlugin.PLUGIN_ID
    }
    
    func dene(){
        mockManagement.clear()
    }

}

