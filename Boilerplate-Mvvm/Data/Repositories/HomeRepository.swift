//
//  HomeRepository.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import Foundation
import RxSwift
import RealmSwift
protocol IHomeRepository {
    func GetHomeItem() -> Single<([Category], [ProductPromo])>
}

class HomeRepository: IHomeRepository  {
    let realm = try! Realm()
    private let homeService : HomeService
    init(homeService : HomeService) {
        self.homeService = homeService
    }
    var allProduct : AllProduct!
    var isUpdate = false
    
    func GetHomeItem() -> Single<([Category], [ProductPromo])> {
        
        let item = realm.objects(AllProduct.self).first
        if let item = item {
            allProduct = item
            isUpdate = true
        } else {
            allProduct = AllProduct()
            isUpdate = false
        }
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let listMockProduct = List<Product>()//allProduct.mockProduct
        
        let products =  homeService.GetHeroes().map { [self] (response) -> ([Category], [ProductPromo]) in
            for item in response[0].data.productPromo{
                listMockProduct.append(item.ToProduct())
            }
            if isUpdate {
                try! realm.write {
                    allProduct.mockProduct = listMockProduct
                }
            } else {
            allProduct.mockProduct = listMockProduct
            realm.beginWrite()
            realm.add(allProduct)
            try! realm.commitWrite()
            }
            return (response[0].data.category , response[0].data.productPromo)
        }
        return products
    }
}

