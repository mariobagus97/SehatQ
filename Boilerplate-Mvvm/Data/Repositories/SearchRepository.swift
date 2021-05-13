//
//  SearchRepository.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 14/05/21.
//

import Foundation
import RxSwift
import RealmSwift

protocol ISearchRepository {
    func getMockData() -> Single<[ProductPromo]>
}

class SearchRepository: ISearchRepository {
    let realm = try! Realm()
    
    func getMockData() -> Single<[ProductPromo]> {
       return Observable<[ProductPromo]>.create { [self] (observer) -> Disposable in
            let item = realm.objects(AllProduct.self).first?.mockProduct
            
            var arrProduct = [ProductPromo]()
            if let mocks = item {
                for mock in mocks {
                    arrProduct.append(ProductPromo(id: mock.id, imageURL: mock.imageURL, title: mock.title, productPromoDescription: mock.productPromoDescription, price: mock.price, loved: mock.loved))
                }
            }
                    observer.onNext(arrProduct)
                    observer.onCompleted()
                    return Disposables.create()
        }.asSingle()
    }
}
