//
//  Capture.swift
//  Cleeng
//
//  Created by Kyle Ishie on 9/14/18.
//

import Foundation

public struct CaptureQuestion : Codable {
    
    public let enabled : Bool
    public let key : String
    public let required : Bool
    
}


extension Cleeng {
    
    public func fetchCaptureQuestions(completion: @escaping ([CaptureQuestion]?, Error?) -> Void) throws {
        let params = [
            "publisherToken" : publisherToken!,
            ]
        
        try performMethod("fetchCaptureQuestions", with: params, completion: completion)
    }
    
    public func fetchCaptureQuestions() throws -> [CaptureQuestion] {
        return try performMethod("fetchCaptureQuestions", with: [
            "publisherToken" : publisherToken!,
        ])
    }
    
}


extension Cleeng {
    
    public struct PersonalData : Codable {
        public var email : String?
        public var firstName : String?
        public var lastName : String?
        public var phoneNumber : String?
        public var address : String?
        public var address2 : String?
        public var city : String?
        public var state : String?
        public var postCode : String?
        public var country : String?
        public var companyName : String?
        
        public struct CustomAnswer : Codable {
            public let questionId : String
            public let value : String?
            
            public init(set questionId: String, to value: String) {
                self.questionId = questionId
                self.value = value
            }
        }
        public var customAnswers : [CustomAnswer]?
        
        public init() {}
    }
    
    private struct PersonalDataUpdateParameters : Codable {
        public let publisherToken : String
        public let userId : Int
        public let newPersonalData : PersonalData
    }
    
    public func updateBroadcasterSpecificPersonalDataWithCaptureAnswers(userId: Int, personalData: PersonalData, completion: @escaping (StatusResponse?, Error?) -> Void) throws {
        let params = PersonalDataUpdateParameters(publisherToken: publisherToken!,
                                                  userId: userId,
                                                  newPersonalData: personalData)

        try performMethod("updateBroadcasterSpecificPersonalDataWithCaptureAnswers", with: params, completion: completion)
    }
    
    @discardableResult
    public func updateBroadcasterSpecificPersonalDataWithCaptureAnswers(userId: Int, personalData: PersonalData) throws -> StatusResponse {
        return try performMethod("updateBroadcasterSpecificPersonalDataWithCaptureAnswers",
                                 with: PersonalDataUpdateParameters(publisherToken: publisherToken!,
                                                                    userId: userId,
                                                                    newPersonalData: personalData))
    }
    
    
    
    private struct PersonalDataFetchParameters : Codable {
        public let publisherToken : String
        public let userId : Int
    }
    
    public func fetchBroadcasterSpecificPersonalDataWithCaptureAnswers(userId: Int, completion: @escaping (PersonalData?, Error?) -> Void) throws {
        let params = PersonalDataFetchParameters(publisherToken: publisherToken!, userId: userId)
        try performMethod("fetchBroadcasterSpecificPersonalDataWithCaptureAnswers", with: params, completion: completion)
    }
    
    @discardableResult
    public func fetchBroadcasterSpecificPersonalDataWithCaptureAnswers(userId: Int) throws -> PersonalData {
        return try performMethod("fetchBroadcasterSpecificPersonalDataWithCaptureAnswers",
                                 with: PersonalDataFetchParameters(publisherToken: publisherToken!, userId: userId))
    }
}
