//
//  Exceptions.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation


internal enum Exceptions : Error {
    case IllegalStateException(message:String)
    case SerializeException(message:String)
}
