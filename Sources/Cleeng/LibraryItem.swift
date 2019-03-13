//
//  LibraryItem.swift
//  Cleeng
//
//  Created by Kyle Ishie on 9/4/18.
//

import Foundation

/*
 {
 "transactionId": "T123123123",
 "transactionDate": 1397830774,
 "transactionPrice": 9.99,
 "transactionCurrency": "USD",
 "transactionExternalData": "",
 "publisherName": "John's Blog",
 "publisherSiteUrl": "http:\/\/blog.johns.org",
 "offerId": "E123123123_US",
 "offerType": "event",
 "offerTitle": "Super Event",
 "offerDescription": "Super Event description",
 "offerUrl": "http:\/\/superevent.cleeng.com\/super-event\/E123123213_US",
 "invoicePrice": 9.99,
 "invoiceCurrency": "USD",
 "expiresAt": "0",
 "cancelled": false
 }
*/
public struct LibraryItem : Codable {
    
    public let transactionId: String
    public let transactionDate: String
    public let transactionPrice: String
    public let transactionCurrency: String
    public let transactionExternalData: String
    public let publisherName: String
    public let publisherSiteUrl: String
    public let offerId: String
    public let offerType: String
    public let offerTitle: String
    public let offerDescription: String
    public let offerUrl: String
    public let invoicePrice: String
    public let invoiceCurrency: String
    public let expiresAt: String
    public let cancelled: Bool
    
}
