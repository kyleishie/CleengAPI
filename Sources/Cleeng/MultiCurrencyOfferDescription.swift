//
//  OfferPriceDescription.swift
//  365Integrations-Server
//
//  Created by Kyle Ishie on 8/25/18.
//

import Foundation

public struct MultiCurrencyOfferPriceDescription : Codable {
    
    public let offerPrice: Double
    public let offerCurrency: String
    public let offerCurrencySymbol: String
    public let offerCountry: String
    public let customerPriceInclTax: Double
    public let customerPriceExclTax: String
    public let customerCurrency: String
    public let customerCurrencySymbol: String
    public let customerCountry: String
    public let offerId: String
    
}

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
    
    public func getMultiCurrencyPrice(offerId: String, ipAddress: String, couponCode: String? = nil, completion: @escaping (MultiCurrencyOfferPriceDescription?, Error?) -> Void) throws {
        let params = [
            "multiCurrencyOfferId" : offerId,
            "ipAddress" : ipAddress
        ]
        
        try performMethod("getMultiCurrencyPrice", with: params, completion: completion)
    }
    
    public func getMultiCurrencyPrice(offerId: String, ipAddress: String, couponCode: String? = nil) throws -> MultiCurrencyOfferPriceDescription {
        return try performMethod("getMultiCurrencyPrice", with: [
            "multiCurrencyOfferId" : offerId,
            "ipAddress" : ipAddress
            ])
    }
    
    
}
