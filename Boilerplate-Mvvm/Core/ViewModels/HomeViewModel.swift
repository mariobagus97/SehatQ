//
//  HomeViewModel.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    private var repo: IHomeRepository
    init(repo : IHomeRepository) {
        self.repo = repo
    }
    
    let ListCategory = BehaviorSubject<[Category]>(value: [Category]())
    let ListProduct = BehaviorRelay<[ProductPromo]>(value: [ProductPromo]())
    
    func getHome() {
        repo.GetHomeItem()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { (value) in
                self.ListCategory.onNext(value.0)
                self.ListProduct.accept(value.1)
            }, onFailure: { (error) in
                self.alertError.onNext(error.localizedDescription)
            })
    }
}
