//
//  Mock.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation

internal struct Mock  : Codable {
    let endpoint: String
    let dummyJsonData: String
    let uniqueId: String
    var queryParams: String = "" // Feature
    var httpCode: Int = 200 // Feature
    var requestType: MockRequestMethods? = nil // var
    var contentTypes: MockContentTypes = MockContentTypes.JSON // Feature
}


internal extension Mock{
    
    func isSameEndpoint(outMock:Mock) -> Bool {
        return uniqueId == outMock.uniqueId
    }
    
    
    func isSameMock(outMock:Mock) -> Bool {
        return endpoint == outMock.endpoint &&
            queryParams == outMock.queryParams && isSameRequestType(outMock: outMock)
    }
    
    func isSameRequestType(outMock:Mock)-> Bool {
        return requestType == nil || outMock.requestType == requestType
    }
}
