//
//  FlipSession.swift
//  FlipperNetworkMockPlugin
//
//  Created by Mustafa Kilic on 26.05.2021.
//

import Foundation
import Alamofire

public class FlipSession {
    
    public static let `default` : SessionManager = {
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            let safeProtocolClasses = [FlipMockUrlProtocol.self] + (configuration.protocolClasses ?? [])
            configuration.protocolClasses = safeProtocolClasses
            return configuration}()
    return SessionManager(configuration:configuration)}()
    
    /**
     # Warning: #
     'As Apple states in their documentation, mutating URLSessionConfiguration properties after the instance has been added to a URLSession (or, in Alamofire’s case, used to initialize aSession) has no effect.'
     https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#session
    
     # Notes: #
     Also you can create custom session
     ```
     private lazy var customMockSession: Session = {
             let configuration: URLSessionConfiguration = {
                 let configuration = URLSessionConfiguration.af.default
                 //@Warning => [FlipMockUrlProtocol.self] should be first
                 let safeProtocolClasses = [FlipMockUrlProtocol.self] + (configuration.protocolClasses ?? [])
                 configuration.protocolClasses = safeProtocolClasses
                 return configuration}()
         return Session(configuration:configuration)}()
     ```
     */

}
