//
//  FlipperConnectionExt.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import FlipperKit


typealias ReceiveSafe = ([AnyHashable:Any],FlipperResponder)->Void

extension FlipperConnection {
    
    func receiveSafe(_ method:String, _ receiveSafe:@escaping ReceiveSafe){
        self.receive(method){  params, responder in
            safeHandle {
                if(params == nil){
                    throw Exceptions.IllegalStateException(message: "Method: \(method) Received params nil!")
                }
                if(responder == nil){
                    throw Exceptions.IllegalStateException(message: "Method: \(method) Received responder nil!")
                }
                receiveSafe(params!,responder!)
            }
        }
    }
    
}


