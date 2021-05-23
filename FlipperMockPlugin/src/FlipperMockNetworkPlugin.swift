//
//  FlipperMockPlugin.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation


struct FlipperMockNetworkPlugin {
    
    static var TAG :String = ""
    static var PLUGIN_ID:String = ""
    static var RUN_IN_BACKGROUND :Bool = false
   
    static var plugin : MockPlugin? = nil
    
    static func getInstance() -> MockPlugin {
        if plugin == nil {
            self.plugin = MockPluginImp.init()
        }
        return plugin!
    }
    
}
