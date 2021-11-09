//
//  InfraTests.swift
//  InfraTests
//
//  Created by Gabriel Santos on 09/11/21.
//

import XCTest
import Alamofire

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) {
        session.request(url).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_() throws {
        let url = makeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        
        sut.post(to: url)
        
        let exp = expectation(description: "waiting")
        
        URLProtocolStub.observeRequest { request in
            exp.fulfill()
            XCTAssertEqual(url, request.url)
        }
        wait(for: [exp], timeout: 1)
    }
}

class URLProtocolStub: URLProtocol {
    
    static var emit: ((URLRequest)-> Void)?
    
    static func observeRequest(completion: @escaping(URLRequest)-> Void) {
        URLProtocolStub.emit = completion
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        URLProtocolStub.emit?(request)
    }
    
    override open func stopLoading() {}
}