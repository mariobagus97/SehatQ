//
//  PurchaseHistoryRepository.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 14/05/21.
//

import Foundation
import RxSwift
import RealmSwift

protocol IPurchaseHistoryRepository {
    func getHistory() -> Single<[ProductPromo]>
}

class PurchaseHistoryRepository: IPurchaseHistoryRepository {
    
    let realm = try! Realm()
    
    func getHistory() -> Single<[ProductPromo]> {
        let realm = try! Realm()
        
           return Observable<[ProductPromo]>.create { (observer) -> Disposable in
            let item = realm.objects(AllProduct.self).first?.productPurchase
                
                var arrProduct = [ProductPromo]()
                if let products = item {
                    for product in products {
                        arrProduct.append(product.ToProductPromo())
                    }
                }
                        observer.onNext(arrProduct)
                        observer.onCompleted()
                        return Disposables.create()
            }.asSingle()
        }
    }

    
