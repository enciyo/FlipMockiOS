//
//  MockInterceptor.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import Alamofire


public class FlipMockUrlProtocol : URLProtocol  {
    
    
    private lazy var mockManagement: MockManagement = {
        return MockManagement.shared
    }()
    
    private let cannedHeaders = ["Content-Type" : "application/json; charset=utf-8"]
   
    
    public override func startLoading(){
        if let exist = mockManagement.findMockOrNull(request.mapMock()),
           let mock = exist.mapResponseData(),
           let url = request.url,
           let response = HTTPURLResponse(url: url, statusCode: exist.httpCode, httpVersion: "HTTP/1.1", headerFields: cannedHeaders){
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed)
            client?.urlProtocol(self, didLoad: mock)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    
    public override class func canInit(with request: URLRequest) -> Bool {
        let mockManagement = MockManagement.shared
        let isMockEnable = mockManagement.config.isMockEnable
        let exist = mockManagement.findMockOrNull(request.mapMock())
        return isMockEnable && exist != nil
    }
    
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
       return request
     }
    

    public override func stopLoading() {}
    
    private func logging(mock:Mock){
        print(mock)
    }
}

extension FlipMockUrlProtocol : URLSessionDelegate {
    func URLSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceiveData data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func URLSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let response = task.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
}
