//
//  Pharmacy.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/18.
//

import Foundation

struct Pharmacy: Decodable {
    let name: String
    let telephone: String
    let address: String
    let close: String
    let type: String
    let time: String

    enum CodingKeys: String, CodingKey {
        case name = "HOSP_NAME"
        case telephone = "TEL"
        case address = "ADDRESS"
        case close = "CLOSESHOP"
        case type = "SPECIAL_TYPE_CNAME"
        case time = "HOLIDAYDUTY_CNAME"
    }
}

struct Records: Decodable {
    let records: [Pharmacy]
}

struct ResponseData: Decodable {
    let result: Records
}
