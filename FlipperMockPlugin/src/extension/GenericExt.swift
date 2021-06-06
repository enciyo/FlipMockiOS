//
//  GenericExt.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation


struct GenericStruct<T> {
    var value: T

    var genericTypeDescription: String {
        return "Generic Type T: '\(T.self)'"
    }

    var typeDescription: String {
        // type(of:) is necessary to exclude the struct's properties from the string
        return "Type: '\(type(of: self))'"
    }
}
