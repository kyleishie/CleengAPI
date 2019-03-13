//
//  ConsentDefinition.swift
//  Cleeng
//
//  Created by Kyle Ishie on 9/14/18.
//

import Foundation
/*
 {
 "broadcasterId": 0,
 "name": "terms",
 "required": true,
 "value": "https://cleeng.com/cleeng-user-agreement",
 "version": "1"
 },
*/
public struct ConsentDefinition : Codable {
    
    public let broadcasterId : Int
    public let name : Name
    public let required : Bool
    public let value : String
    public let version : String
    
    
    public enum Name : String, Codable {
        case terms
        case privacy
        case broadcasterTerms = "broadcaster_terms"
        case broadcasterMarketing = "broadcaster_marketing"
    }
    
}

extension Cleeng {
    
    public func getConsentDefinitions(completion: @escaping ([ConsentDefinition]?, Error?) -> Void) throws {
        let params = [
            "publisherToken" : publisherToken!,
            ]
        
        try performMethod("getConsentDefinitions", with: params, completion: completion)
    }
    
    public func getConsentDefinitions() throws -> [ConsentDefinition] {
        return try performMethod("getConsentDefinitions", with: [
            "publisherToken" : publisherToken!,
        ])
    }
    
}

extension Cleeng {
    
    public enum ConsentSubmissionState : String, Codable {
        case accepted
        case declined
    }

    
    
    public func submitConsent(customerEmail: String, name: ConsentDefinition.Name, state: ConsentSubmissionState, version: String, completion: @escaping (Bool?, Error?) -> Void) throws {
        let params = [
            "publisherToken" : publisherToken!,
            "customerEmail" : customerEmail,
            "name" : name.rawValue,
            "state" : state.rawValue,
            "version" : version
            ]
        
        try performMethod("submitConsent", with: params, completion: { (response: StatusResponse?, error: Error?) in
            completion(response?.success, error)
        })
    }
    
    @discardableResult
    public func submitConsent(customerEmail: String, name: ConsentDefinition.Name, state: ConsentSubmissionState, version: String) throws -> Bool {
        return (try performMethod("submitConsent", with: [
            "publisherToken" : publisherToken!,
            "customerEmail" : customerEmail,
            "name" : name.rawValue,
            "state" : state.rawValue,
            "version" : version
        ]) as StatusResponse).success
    }
    
}

extension Cleeng {
    
    public struct ViewerConsent : Codable {
        public let broadcasterId: Int
        public let date: Date
        public let name : ConsentDefinition.Name
        public let needsUpdate : Bool
        public let state : ConsentSubmissionState
        public let userId : Int
        public let version : String
    }
    
    public func getViewerConsents(customerEmail: String, completion: @escaping ([ViewerConsent]?, Error?) -> Void) throws {
        let params = [
            "publisherToken" : publisherToken!,
            "customerEmail" : customerEmail
            ]
        
        try performMethod("getViewerConsents", with: params, completion: completion)
    }
    
    public func getViewerConsents(customerEmail: String) throws -> [ViewerConsent] {
        return try performMethod("getViewerConsents", with: [
            "publisherToken" : publisherToken!,
            "customerEmail" : customerEmail
        ])
    }
    
}
