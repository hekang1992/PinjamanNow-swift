//
//  ProvicesModelManager.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/5.
//


import BRPickerView

class CitysManager {
    static let shared = CitysManager()
    private init() {}
    var citysModel: [argentficationModel]?
}

struct ProvincesDecodeModel {
    static func getAddressModelArray(dataSourceArr: [argentficationModel]) -> [BRTextModel] {
        return dataSourceArr.enumerated().map {
            $0.element.toBRTextModel(at: $0.offset, depth: .province)
        }
    }
}

extension argentficationModel {
    enum ModelDepth {
        case province, city, area
    }
    
    func toBRTextModel(at index: Int, depth: ModelDepth) -> BRTextModel {
        let model = BRTextModel()
        model.code = bebit ?? ""
        model.text = sy ?? ""
        model.index = index
        
        switch depth {
        case .province:
            model.children = taxish?.enumerated().map {
                $0.element.toBRTextModel(at: $0.offset, depth: .city)
            } ?? []
        case .city:
            model.children = taxish?.enumerated().map {
                $0.element.toBRTextModel(at: $0.offset, depth: .area)
            } ?? []
        case .area:
            model.children = []
        }
        
        return model
    }
}
