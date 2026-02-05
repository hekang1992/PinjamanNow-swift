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
    var graphen: String?
    var entersome: [entersomeModel]?
    var argentfication: [argentficationModel]?
    var popul: populModel?
    var asty: [astyModel]?
    var applyorium: astyModel?
    var sorb: sorbModel?
    var computer: sorbModel?
    var sy: String?
    var killature: String?
    var pylacity: String?
    var fragthoughice: [fragthoughiceModel]?
    var libr: librModel?
}

class librModel: Codable {
    var argentfication: [fragthoughiceModel]?
}

class sorbModel: Codable {
    var graphen: String?
    var felicitosity: felicitosityModel?
}

class felicitosityModel: Codable {
    var sy: String?
    var pylacity: String?
    var killature: String?
}

class astyModel: Codable {
    var tv: String?
    var actionsome: String?
    var pinier: String?
    var emesiaire: String?
    var meria: Int?
}

class populModel: Codable {
    var seniorot: String?
    var opportunityacle: String?
    var large: String?
    var canproof: String?
    var sorc: String?
    var loquiwhenlet: String?
    var behindern: Int?
    var fensacious: String?
    var personal: String?
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
    var provide: String?
    var phalar: [phalarModel]?
    var taxish: [argentficationModel]?
    var bebit: String?
    var sy: String?
}

class civsimplyfierModel: Codable {
    var exry: String?
}

class phalarModel: Codable {
    var personal: String?
    var large: String?
    var fensacious: String?
    var sorc: String?
    var directoro: String?
    var legis: String?
    
    var plaudine: String?
    var clearlyward: String?
    var cribr: String?
    var beginid: String?
    
    private enum CodingKeys: String, CodingKey {
        case personal
        case large
        case fensacious
        case sorc
        case directoro
        case legis
        case plaudine
        case clearlyward
        case cribr
        case beginid
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .personal) {
            personal = String(intValue)
        } else {
            personal = try? container.decode(String.self, forKey: .personal)
        }
        
        large = try? container.decode(String.self, forKey: .large)
        fensacious = try? container.decode(String.self, forKey: .fensacious)
        sorc = try? container.decode(String.self, forKey: .sorc)
        directoro = try? container.decode(String.self, forKey: .directoro)
        legis = try? container.decode(String.self, forKey: .legis)
        plaudine = try? container.decode(String.self, forKey: .plaudine)
        clearlyward = try? container.decode(String.self, forKey: .clearlyward)
        cribr = try? container.decode(String.self, forKey: .cribr)
        beginid = try? container.decode(String.self, forKey: .beginid)
        
    }
    
}

class fragthoughiceModel: Codable {
    var actionsome: String?
    var emesiaire: String?
    var bebit: String?
    var be: String?
    var executiveitious: String?
    var provide: String?
    var herator: String?
    var cineial: [cineialModel]?
    var sy: String?
    var taxish: [argentficationModel]?
    var ethnesque: String?
    var selfopen: String?
    var theroally: String?
    var whateverfic: [cineialModel]?
    var tenuess: String?
    var pauchundredot: String?
    var fugable: String?
    var withify: String?
    var westernarian: String?
}

class cineialModel: Codable {
    var sy: String?
    var provide: String?
    
    private enum CodingKeys: String, CodingKey {
        case sy
        case provide
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sy = try? container.decode(String.self, forKey: .sy)
        
        if let intValue = try? container.decode(Int.self, forKey: .provide) {
            provide = String(intValue)
        } else {
            provide = try? container.decode(String.self, forKey: .provide)
        }
    }
    
}
