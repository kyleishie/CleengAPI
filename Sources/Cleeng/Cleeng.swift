//
//  Cleeng.swift
//  Swift 4.0
//  Created by Kyle Ishie, Kyle Ishie Development.
//


import Foundation
import Dispatch
public class Cleeng {
    
    /// https://www.jsonrpc.org/specification
    public struct JSONRPC {
        
        public struct Request<P : Codable> : Codable {
            private let jsonRPC = "2.0"
            private let id : String
            private let method : String
            private let params : P
            
            enum CodingKeys : String, CodingKey {
                case jsonRPC = "json-rpc"
                case id
                case method
                case params
            }
            
            init(id: String = "1", method: String, params: P) {
                self.id = id
                self.method = method
                self.params = params
            }
            
        }
        
        public struct Error : Swift.Error, Codable {
//            public let code : String
            public let message : String?
            //            public let data : Any?
        }
        
        public struct Response<R : Codable> : Codable {
            public let error : Error?
            public let id : String?
            public let result : R?
            
        }
        
    }
    
    public struct StatusResponse : Codable {
        public let success : Bool
    }
    
    public var publisherToken : String? = nil
    
    public init(publisherToken: String? = nil) {
        self.publisherToken = publisherToken
    }
    
    private enum APIUrl : String {
        case production = "https://api.cleeng.com/3.0/json-rpc"
        case sandbox = "https://sandbox.cleeng.com/api/3.0/json-rpc"
    }
    
    private var baseURL : URL {
        return isSandbox ? URL(string: APIUrl.sandbox.rawValue)! : URL(string: APIUrl.production.rawValue)!
    }
    
    public var isSandbox : Bool = false
    
    
    private let session : URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        return URLSession(configuration: sessionConfig)
    }()
    
    private func performRequest<P : Codable, R : Codable>(_ request: JSONRPC.Request<P>, completion: @escaping (JSONRPC.Response<R>?, Error?) -> Void) throws {
        var httpRequest = URLRequest(url: baseURL)
        httpRequest.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
#if os(macOS)
        encoder.outputFormatting = .prettyPrinted
#endif
        
        httpRequest.httpBody = try encoder.encode(request)
        
#if os(macOS)
        print(String(data: httpRequest.httpBody!, encoding: .utf8)!)
#endif
        
        let task = session.dataTask(with: httpRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error!)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                                
                let rpcResponse = try decoder.decode(JSONRPC.Response<R>.self, from: data)
                
                guard rpcResponse.error == nil else {
                    completion(nil, rpcResponse.error!)
                    return
                }
                
                completion(rpcResponse, nil)
                
                
            } catch {
                completion(nil, error)
            }
            
        }
        
        task.resume()
    }

    
    public func performMethod<P : Codable, R : Codable>(_ method: String, with params: P, id: String = "1", completion: @escaping (R?, Error?) -> Void) throws {
        
        let request = JSONRPC.Request(id: id, method: method, params: params)
        try performRequest(request) { (response: JSONRPC.Response<R>?, error: Error?) in
            completion(response?.result, error)
            
        }
        
    }
    
    public func performMethod<P : Codable, R : Codable>(_ method: String, with params: P, id: String = "1") throws -> R {
        
        let request = JSONRPC.Request(id: id, method: method, params: params)
        
        let block = DispatchSemaphore(value: 0)
        var response: R? = nil
        var error: Error? = nil
        
        try performRequest(request) { (r: JSONRPC.Response<R>?, e: Error?) in
            response = r?.result
            error = e
            block.signal()
        }
        
        _ = block.wait(timeout: DispatchTime.distantFuture)
        
        if let e = error {
            throw e
        } else {
            return response!
        }
    }
    
}

internal protocol SignedParams {
    
    var publisherToken : String { get set }
    
}


