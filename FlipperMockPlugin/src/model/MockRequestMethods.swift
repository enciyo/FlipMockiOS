//
//  MockRequestMethods.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation

internal enum MockRequestMethods: String, Codable {
    case POST = "Post"
    case GET = "Get"
    case PUT = "Put"
    case DELETE = "Delete";
    
    static func safeValueOf(value: String) -> MockRequestMethods? {
        var result: MockRequestMethods?{
            switch value {
            case "POST":
                return MockRequestMethods.POST
            case "GET":
                return MockRequestMethods.GET
            case "PUT":
                return MockRequestMethods.PUT
            case "DELETE":
                return MockRequestMethods.DELETE
            default:
                return nil
            }
        }
        return result
    }
}
