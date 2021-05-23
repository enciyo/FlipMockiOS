//
//  MockInterceptor.swift
//  FlipperMockPlugin
//
//  Created by Mustafa Kilic on 22.05.2021.
//

import Foundation
import Alamofire


class MockUrlProtocol : URLProtocol  {
    
    
    private var mockManagement: MockManagement = FlipperMockNetworkPlugin.getInstance().mockManagement
    private let cannedHeaders = ["Content-Type" : "application/json; charset=utf-8"]
   
    
    
    lazy var session: URLSession = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
                return configuration
            }()
            let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
            return session
        }()
    
    override func startLoading(){
        let isMockEnable = mockManagement.config.isLoggable
        let isLogable = mockManagement.config.isLoggable
        if isMockEnable {
            if let exist = mockManagement.findFirstOrNullMock(requestMock: request.mapMock()),
               let mock = exist.mapResponseData(),
               let url = request.url,
               let response = HTTPURLResponse(url: url, statusCode: exist.httpCode, httpVersion: "HTTP/1.1", headerFields: cannedHeaders){
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed)
                client?.urlProtocol(self, didLoad: mock)
                if isLogable {
                    logging(mock: exist)
                }
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return URLProtocol.property(forKey: FlipperMockNetworkPlugin.PLUGIN_ID,in: request) == nil
    }
    
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
       return request
     }
    

     override func stopLoading() {}
    
    private func logging(mock:Mock){
        print(mock)
    }
}

extension MockUrlProtocol: URLSessionDelegate {
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
