//
//  AccessStatus.swift
//  365Chat-Server
//
//  Created by Kyle Ishie on 8/15/18.
//

import Foundation

public struct AccessStatus : Codable {
    
    public let accessGranted: Bool
//    public let grantType: String?
//    public let expiresAt: String?
    
}

extension Cleeng {
    
    public func getAccessStatus(customerToken: String, offerId: String, ipAddress: String? = nil, completion: @escaping (AccessStatus?, Error?) -> Void) throws {
        var params = [
            "customerToken" : customerToken,
            "offerId" : offerId,
            ]
        
        if let ip = ipAddress {
            params["ipAddress"] = ip
        }
        
        try performMethod("getAccessStatus", with: params, completion: completion)
    }
    
    public func getAccessStatus(customerToken: String, offerId: String, ipAddress: String? = nil) throws -> AccessStatus {
        var params = [
            "customerToken" : customerToken,
            "offerId" : offerId,
            ]
        
        if let ip = ipAddress {
            params["ipAddress"] = ip
        }
        
        return try performMethod("getAccessStatus", with: params)
    }
    
}
