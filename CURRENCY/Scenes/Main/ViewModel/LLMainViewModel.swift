//
//  LLCatalogViewModel.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/23.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import Bond
import Aletheia
import Foundation
import ReactiveKit

/// LLMainViewModel
final class LLMainViewModel {

    let banners = MutableObservableArray<String>()
    
    let contents = MutableObservableArray<LLShopModel?>()
    
    /// FIXME:  使用 notify 機制？
    private var temp = Array<LLShopModel>([])
    
    private let concurrency = DispatchGroup()
    
    init() { }
    
    func getCatalogs() -> [LLCatalogModel] {
        return [
            LLCatalogModel(catalog: .brand),
            LLCatalogModel(catalog: .breakfast),
            LLCatalogModel(catalog: .celebrity),
            LLCatalogModel(catalog: .drink),
            LLCatalogModel(catalog: .favorite),
            LLCatalogModel(catalog: .health),
            LLCatalogModel(catalog: .nearby),
            LLCatalogModel(catalog: .recommend),
            LLCatalogModel(catalog: .scan),
            LLCatalogModel(catalog: .use)
        ]
    }
    
    func requestAPI(completion: @escaping (_ any: Any?) -> ()) {
        LLCommercialClient().start { (response) in
            
            guard let data = response.value as? Data else {
                completion(APIError(code: nil, message: response.error?.localizedDescription))
                return
            }
            
            if let object = self.parseJSON(data: data) {
                
                for element in object.data {
                    self.concurrency.enter()
                    self.requestGetShopAPI(id: element.id)
                }
                
                self.concurrency.notify(queue: .main, execute: {
                    self.contents.insert(contentsOf: self.temp, at: 0)
                    completion(nil)
                })
                
            } else {
                completion(data.al.jsonErrorType(type: APIError.self))
            }
        }
    }
    
    func requestGetShopAPI(id: String) {
        LLGetShopClient(commercialID: id).start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseShopJSON(data: data) {
                    self.temp.append(object)
                }
            }
            self.concurrency.leave()
        }
    }
    
    func requestBannerAPI() {
        LLBannerClient().start { (response) in
            if let data = response.value as? Data {
                if let object = self.parseBannerJSON(data: data) {
                    self.banners.insert(contentsOf: self.mapURLs(object: object), at: 0)
                }
            }
        }
    }
    
    /// Deal with image source URL
    ///
    /// - Parameter sender: banner model object
    /// - Returns: [Image URL]
    private func mapURLs(object: LLBannerModel) -> [String] {
        guard let path = object.imgpath else { return [] }
        var temp: [String] = []
        for element in object.data {
            if let imageFile = element.imgfile1 {
                temp.append(path + imageFile)
            }
        }
        return temp
    }
}

extension LLMainViewModel {
    
    func parseJSON(data: Data) -> LLCommercialModel? {
        return data.al.jsonType(type: LLCommercialModel.self)
    }
    
    func parseShopJSON(data: Data) -> LLShopModel? {
        return data.al.jsonType(type: LLShopModel.self)
    }
    
    func parseBannerJSON(data: Data) -> LLBannerModel? {
        return data.al.jsonType(type: LLBannerModel.self)
    }
}




