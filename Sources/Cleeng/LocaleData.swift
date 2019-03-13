//
//  LocaleData.swift
//  Cleeng
//
//  Created by Kyle Ishie on 9/4/18.
//

import Foundation

/*
 {
 "country": "FR",
 "currency": "EUR",
 "locale": "fr_FR"
 }
*/
public struct LocaleData : Codable {
    
    public let country : String
    public let currency : String
    public let locale : String
    
}


extension Cleeng {
    
    
    public func getLocaleDataFromIp(_ ipAddress: String, completion: @escaping (LocaleData?, Error?) -> Void) throws {
        let params = [
            "ipAddress" : ipAddress
        ]
        
        try performMethod("getLocaleDataFromIp", with: params, completion: completion)
    }
    
    public func getLocaleDataFromIp(_ ipAddress: String) throws -> LocaleData {
        return try performMethod("getLocaleDataFromIp", with: [
            "ipAddress" : ipAddress
            ])
    }
    
    
}
