//
//  FlipperMockPlugin.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import Alamofire

public class FlipMock {
        
    public static let plugin : MockPlugin  = MockPluginImp.init() as MockPlugin
    
    internal static let PLUGIN_ID:String = "flipper-plugin-enciyo-flipmock"
    internal static let RUN_IN_BACKGROUND :Bool = true
    

}

public let FM = FlipSession.default
