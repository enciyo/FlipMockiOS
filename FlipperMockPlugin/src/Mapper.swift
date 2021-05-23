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
            endpoint: try self.map("endpoint"),
            dummyJsonData: try self.map("dummyJsonData"),
            uniqueId: try self.map("uniqueId")
        )
    }
    
    func mapConfig() throws -> Config {
        return Config(
            isLoggable: try self.map("isLoggable"),
            isMockEnable: try self.map("isMockEnable")
        )
    }
    
    
    
    func map<T> (_ param:String) throws -> T {
        let obje = self[param]
        if obje == nil {
            throw Exceptions.SerializeException(message: "Expected \(param) nil")
        }
        if (obje as? T == nil)  {
            throw Exceptions.SerializeException(message: "\(param) expected type: '\(type(of: self))")
        }
        return obje as! T
    }
}


internal extension Mock {
    
    func mapResponseData() -> Data? {
        let decoder = JSONEncoder()
        return try? decoder.encode(self)
    }
}

internal extension Alamofire.URLRequest {
    
    func mapMock() -> Mock {
        return Mock(
            endpoint: (url?.path)!,
            dummyJsonData: "", //Not used
            uniqueId: "" // Not Used
        )
    }
    
}

