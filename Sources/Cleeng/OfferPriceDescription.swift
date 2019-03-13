//
//  OfferPriceDescription.swift
//  365Integrations-Server
//
//  Created by Kyle Ishie on 8/25/18.
//

import Foundation

public struct OfferPriceDescription : Codable {
    
    public let offerPrice: Double
    public let offerCurrency: String
    public let offerCurrencySymbol: String
    public let offerCountry: String
    public let customerPriceInclTax: Double
    public let customerPriceExclTax: String
    public let customerCurrency: String
    public let customerCurrencySymbol: String
    public let customerCountry: String
    public let discountedCustomerPriceInclTax: String
    public let discountedCustomerPriceExclTax: String
    public let discountPeriods: String
    
}


/*
 
 "offerPrice": 6.99,
 "offerCurrency": "USD",
 "offerCurrencySymbol": "$",
 "offerCountry": "US",
 "customerPriceInclTax": 6.99,
 "customerPriceExclTax": "6.99",
 "customerCurrency": "USD",
 "customerCurrencySymbol": "$",
 "customerCountry": "US",
 "discountedCustomerPriceInclTax": "n\/a",
 "discountedCustomerPriceExclTax": "n\/a",
 "discountPeriods": "n\/a"
 
*/

/*
 {
 "offerPrice": 11.9974,
 "offerCurrency": "EUR",
 "offerCurrencySymbol": "\u20ac",
 "offerCountry": "BE",
 "customerPriceInclTax": 12.1974,
 "customerPriceExclTax": 9.9174,
 "customerCurrency": "EUR",
 "customerCurrencySymbol": "\u20ac",
 "customerCountry": "FR",
 "offerId": "S325990213_FR"
 }
*/

extension Cleeng {
    
    public func getPrice(offerId: String, ipAddress: String, couponCode: String? = nil, completion: @escaping (OfferPriceDescription?, Error?) -> Void) throws {
        let params = [
            "offerId" : offerId,
            "ipAddress" : ipAddress
        ]
        
        try performMethod("getPrice", with: params, completion: completion)
    }
    
    public func getPrice(offerId: String, ipAddress: String, couponCode: String? = nil) throws -> OfferPriceDescription {
        return try performMethod("getPrice", with: [
            "offerId" : offerId,
            "ipAddress" : ipAddress
        ])
    }
    
    
}
