//
//  Regional.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/19.
//

import Foundation

struct Region: Decodable {
    let name: String
    let telephone: String
    let address: String
    let close: String
    let type: String
    let time: String
    let service: String
    let other: String

    enum CodingKeys: String, CodingKey {
        case name = "HOSP_NAME"
        case telephone = "TEL"
        case address = "ADDRESS"
        case close = "CLOSESHOP"
        case type = "FUNCTYPE_CNAME"
        case time = "HOLIDAYDUTY_CNAME"
        case service = "SERVICE_CNAME"
        case other = "HOLIDAY_REMARK_CNAME"
    }
}

struct RegionRecords: Decodable {
    let records: [Region]
}

struct RegionResponseData: Decodable {
    let result: RegionRecords
}
