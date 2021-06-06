//
//  Mapper.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import Alamofire

internal extension Dictionary where Key == AnyHashable {

    func mapMock() throws -> Mock  {
        return Mock(
            endpoint: try parseMap("endpoint", transform: {item -> String in item }),
            dummyJsonData: try parseMap("dummyJsonData", transform: {item -> String in item.description }),
            uniqueId: try parseMap("uniqueId", transform: {item -> String in item })
        )
    }
    
    func mapConfig() throws -> Config {
        return Config(
            isLoggable: try parseMap("isLogable", transform: {item -> Bool in item }),
            isMockEnable: try parseMap("isMockEnable", transform: {item -> Bool in item })
        )
    }
    
    func parseMap<T>(_ param:String, transform: (T) -> T) throws -> T {
        let obje = self[param]
        if obje == nil {
            throw Exceptions.SerializeException(message: "Expected \(param) nil")
        }
        if (obje as? T == nil)  {
            throw Exceptions.SerializeException(message: "\(param) expected type: '\(type(of: T.self))")
        }
        return obje as! T
    }
}


internal extension Mock {
    
    func mapResponseData() -> Data? {
        return self.dummyJsonData.data(using: String.Encoding.utf8)
    }
}

internal extension Alamofire.URLRequest {
    
    func mapMock() -> Mock {
        return Mock(
            endpoint: url?.path ?? String.Unique,
            dummyJsonData: String.Unique,
            uniqueId: String.Unique
        )
    }
}

extension String {
    
    static var Unique: String {
        get { return Foundation.UUID().uuidString }
    }
}

