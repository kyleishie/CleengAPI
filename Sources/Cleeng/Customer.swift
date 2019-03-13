//
//  Customer.swift
//  365Chat-Server
//
//  Created by Kyle Ishie on 8/15/18.
//

import Foundation

public typealias CustomerToken = String

public struct Customer : Codable, Hashable {
    
    public let id: String
    public let email: String
    public let displayName: String
    public let firstName: String
    public let lastName: String
    public let currency: String
    public let locale: String
    public let country: String
    
    public var initials: String {
        if let first = firstName.first, let last = lastName.first {
            return String([first, last])
        }
        
        return String(displayName[displayName.startIndex...displayName.index(after: displayName.startIndex)])
    }
    
    
}

extension Cleeng {
    
    public func getCustomer(customerToken: String, completion: @escaping (Customer?, Error?) -> Void) throws {
        let params = [
            "customerToken" : customerToken,
            ]
        
        try performMethod("getCustomer", with: params, completion: completion)
    }
    
    public func getCustomer(customerToken: String) throws -> Customer {
        return try performMethod("getCustomer", with: [
            "customerToken" : customerToken,
            ])
    }
    
}



extension Customer {
    
    public struct CreationContext : Codable {
        public let email : String
        public let locale : String
        public let country : String
        public let currency : String
        public var password : String?
        public let facebookId : String?
        
        public init(email: String, locale: String, country: String, currency: String, password: String? = nil, facebookId: String? = nil) {
            self.email = email
            self.locale = locale
            self.country = country
            self.currency = currency
            self.password = password
            self.facebookId = facebookId
        }
        
        public init(email: String, password: String? = nil, facebookId: String? = nil, localeData: LocaleData) {
            self.email = email
            self.locale = localeData.locale
            self.country = localeData.country
            self.currency = localeData.currency
            self.password = password
            self.facebookId = facebookId
        }
    }
    
    public struct Auth : Codable {
        public let token : CustomerToken
    }
    
}

extension Cleeng {
    
    private struct RegisterCustomerParams : Codable {
        let publisherToken : String
        let customerData : Customer.CreationContext
    }
    
    public func registerCustomer(_ creationContext: Customer.CreationContext, completion: @escaping (Customer.Auth?, Error?) -> Void) throws {
        let params = RegisterCustomerParams(publisherToken: publisherToken!, customerData: creationContext)
        try performMethod("registerCustomer", with: params, completion: completion)
    }
    
    public func registerCustomer(_ creationContext: Customer.CreationContext) throws -> Customer.Auth {
        let params = RegisterCustomerParams(publisherToken: publisherToken!, customerData: creationContext)
        return try performMethod("registerCustomer", with: params)
    }
    
}

extension Cleeng {
    
    public func generateCustomerTokenFromPassword(_ password: String, customerEmail: String, completion: @escaping (Customer.Auth?, Error?) -> Void) throws {
        let params = [
            "publisherToken" : publisherToken!,
            "password" : password,
            "customerEmail" : customerEmail
        ]
        try performMethod("generateCustomerTokenFromPassword", with: params, completion: completion)
    }
    
    public func generateCustomerTokenFromPassword(_ password: String, customerEmail: String) throws -> Customer.Auth {
        return try performMethod("generateCustomerTokenFromPassword", with: [
            "publisherToken" : publisherToken!,
            "password" : password,
            "customerEmail" : customerEmail
        ])
    }
    
    public func generateCustomerTokenFromFacebook(_ facebookId: String, customerEmail: String, completion: @escaping (Customer.Auth?, Error?) -> Void) throws {
        let params = [
            "publisherToken" : publisherToken!,
            "facebookId" : facebookId,
            "customerEmail" : customerEmail
        ]
        try performMethod("generateCustomerTokenFromPassword", with: params, completion: completion)
    }
    
    public func generateCustomerTokenFromFacebook(_ facebookId: String, customerEmail: String) throws -> Customer.Auth {
        return try performMethod("generateCustomerTokenFromPassword", with: [
            "publisherToken" : publisherToken!,
            "facebookId" : facebookId,
            "customerEmail" : customerEmail
            ])
    }
    
}

extension Cleeng {
    
    private struct UrlWrapper : Codable {
        public let url: URL
    }
    
    private struct CheckoutUrlParams : Codable {
        public let customerEmail : String
        public let publisherToken : String
        
        public struct FlowDescription : Codable {
            public let offerId : String
            public let redirectUrl : URL?
        }
        
        public let flowDescription: FlowDescription
    }
    
    public func generateCheckoutUrl(for customerEmail: String, offerId: String, redirectUrl: URL? = nil, completion: @escaping (URL?, Error?) -> Void) throws {
        
        let params = CheckoutUrlParams(customerEmail: customerEmail,
                                       publisherToken: publisherToken!,
                                       flowDescription: Cleeng.CheckoutUrlParams.FlowDescription(offerId: offerId,
                                                                                                 redirectUrl: redirectUrl))
        
        try performMethod("generateCheckoutUrl", with: params, completion: { (urlWrapper: UrlWrapper?, error: Error?) in
            completion(urlWrapper?.url, error)
        })
    }
    
    public func generateCheckoutUrl(for customerEmail: String, offerId: String, redirectUrl: URL? = nil) throws -> URL {
        let params = CheckoutUrlParams(customerEmail: customerEmail,
                                       publisherToken: publisherToken!,
                                       flowDescription: Cleeng.CheckoutUrlParams.FlowDescription(offerId: offerId,
                                                                                                 redirectUrl: redirectUrl))
        return (try performMethod("generateCheckoutUrl", with: params) as UrlWrapper).url
    }
    
}


extension Cleeng {
    
    public enum Module : String, Codable {
        case profile
        case payment
        case subscriptions
        case transactions
        case affiliateTracking = "affiliate-tracking"
        case consentsList = "consents-list"
    }
    
    private struct MyAccountUrlParams : Codable {
        public let customerEmail : String
        public let publisherToken : String
        public let modules: [Module]
    }
    
    public func generateMyAccountUrl(for customerEmail: String, modules: [Module] = [.profile, .payment], completion: @escaping (URL?, Error?) -> Void) throws {
        
        let params = MyAccountUrlParams(customerEmail: customerEmail,
                                        publisherToken: publisherToken!,
                                        modules: modules)
        
        try performMethod("generateMyAccountUrl", with: params, completion: { (urlWrapper: UrlWrapper?, error: Error?) in
            completion(urlWrapper?.url, error)
        })
    }
    
    public func generateMyAccountUrl(for customerEmail: String, modules: [Module] = [.profile, .payment]) throws -> URL {
        let params = MyAccountUrlParams(customerEmail: customerEmail,
                                        publisherToken: publisherToken!,
                                        modules: modules)
        return (try performMethod("generateMyAccountUrl", with: params) as UrlWrapper).url
    }
    
}

