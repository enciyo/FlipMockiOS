//
//  MockPlugin.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import FlipperKit


protocol MockPlugin : NSObject, FlipperPlugin {
    var mockManagement : MockManagement {get}
}


