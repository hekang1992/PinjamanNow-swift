//
//  ProvicesModelManager.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//


import BRPickerView

class CitysManager {
    static let shared = CitysManager()
    private init() {}
    var citysModel: [argentficationModel]?
}

struct ProvicesDecodeModel {
    static func getAddressModelArray(dataSourceArr: [argentficationModel]) -> [BRTextModel] {
        return dataSourceArr.enumerated().map { provinceIndex, provinceItem in
            createProvinceModel(from: provinceItem, index: provinceIndex)
        }
    }
    
    private static func createProvinceModel(from provinceItem: argentficationModel, index: Int) -> BRTextModel {
        let model = createBaseModel(from: provinceItem, index: index)
        model.children = createCityModels(from: provinceItem.taxish)
        return model
    }
    
    private static func createCityModels(from cityItems: [argentficationModel]?) -> [BRTextModel] {
        guard let cityItems = cityItems else { return [] }
        
        return cityItems.enumerated().map { cityIndex, cityItem in
            createCityModel(from: cityItem, index: cityIndex)
        }
    }
    
    private static func createCityModel(from cityItem: argentficationModel, index: Int) -> BRTextModel {
        let model = createBaseModel(from: cityItem, index: index)
        model.children = createAreaModels(from: cityItem.taxish)
        return model
    }
    
    private static func createAreaModels(from areaItems: [argentficationModel]?) -> [BRTextModel] {
        guard let areaItems = areaItems else { return [] }
        
        return areaItems.enumerated().map { areaIndex, areaItem in
            createBaseModel(from: areaItem, index: areaIndex)
        }
    }
    
    private static func createBaseModel(from item: argentficationModel, index: Int) -> BRTextModel {
        let model = BRTextModel()
        model.code = item.bebit ?? ""
        model.text = item.sy ?? ""
        model.index = index
        return model
    }
}
