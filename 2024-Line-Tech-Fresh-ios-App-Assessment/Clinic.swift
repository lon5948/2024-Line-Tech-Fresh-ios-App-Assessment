//
//  Clinic.swift
//  2024-Line-Tech-Fresh-ios-App-Assessment
//
//  Created by LON Li on 2024/4/18.
//

import Foundation

struct Clinic: Decodable {
    let name: String
    let telephone: String
    let address: String
    let close: String
    let type: String
    let time: String
    let service: String

    enum CodingKeys: String, CodingKey {
        case name = "HOSP_NAME"
        case telephone = "TEL"
        case address = "ADDRESS"
        case close = "CLOSESHOP"
        case type = "FUNCTYPE_CNAME"
        case time = "HOLIDAYDUTY_CNAME"
        case service = "SERVICE_CNAME"
    }
}

struct ClinicRecords: Decodable {
    let records: [Clinic]
}

struct ClinicResponseData: Decodable {
    let result: ClinicRecords
}
