//
//  PurchaseHistoryViewModel.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 13/05/21.
//

import Foundation
import RxSwift
import RxCocoa

class PurchaseHistoryViewModel: BaseViewModel {
    
    let ListProduct = BehaviorRelay<[ProductPromo]>(value: [ProductPromo]())
    
    private var repo: IPurchaseHistoryRepository
    init(repo : IPurchaseHistoryRepository) {
        self.repo = repo
    }
    
    func GetHistoryPurchase() {
        repo.getHistory()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { (value) in
                self.ListProduct.accept(value)
            }, onFailure: { (error) in
                self.alertError.onNext(error.localizedDescription)
            })
    }
}
