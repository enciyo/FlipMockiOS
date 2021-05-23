//
//  ExceptionExt.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation

func safeHandle(closure: @escaping () throws ->()){
    do {
        try closure()
    } catch(let error) {
        print(error)
    }
}


