//
//  ProductDetailRepository.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 14/05/21.
//

import Foundation
import RxSwift
import RealmSwift

protocol IProductDetailRepository {
    func buyProduct(product : ProductPromo)
}

class ProductDetailRepository: IProductDetailRepository {
    let realm = try! Realm()
    
    func buyProduct(product: ProductPromo) {
        let item = realm.objects(AllProduct.self).first
        if let item = item {
            try! realm.write {
                item.productPurchase.append(product.ToProduct())
            }
        }
    }
}

