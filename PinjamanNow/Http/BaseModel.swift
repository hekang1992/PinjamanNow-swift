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
    
    private enum CodingKeys: String, CodingKey {
        case bebit, calcfootment, record
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .bebit) {
            bebit = String(intValue)
        } else {
            bebit = try? container.decode(String.self, forKey: .bebit)
        }
        
        calcfootment = try? container.decode(String.self, forKey: .calcfootment)
        record = try? container.decode(recordModel.self, forKey: .record)
    }
    
}

class recordModel: Codable {
    var americanate: String?
    var camera: String?
    var salinee: String?
    var entersome: [entersomeModel]?
    var argentfication: [argentficationModel]?
}

class entersomeModel: Codable {
    var actionsome: String?
    var ponder: String?
    var joinency: String?
}

class argentficationModel: Codable {
    var manu: String?
    var large: String?
    var fensacious: String?
    var sorc: String?
    var faci: String?
    var executiveable: String?
    var affectoon: String?
    var igmillionical: String?
    var vulgfication: String?
    var gamery: String?
    var hear: String?
    var civsimplyfier: civsimplyfierModel?
}

class civsimplyfierModel: Codable {
    var exry: String?
}
