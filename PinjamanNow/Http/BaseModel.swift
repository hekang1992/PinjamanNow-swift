//
//  BaseModel.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/3.
//

class BaseModel: Codable {
    var bebit: String?
    var calcfootment: String?
    var record: recordModel?
}

class recordModel: Codable {
    var americanate: String?
}
