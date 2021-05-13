//
//  SearchViewModel.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 13/05/21.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: BaseViewModel {
    
    var ListProduct = BehaviorRelay<[ProductPromo]>(value: [ProductPromo]())
    
    
    private var repo: ISearchRepository
    init(repo : ISearchRepository) {
        self.repo = repo
    }
    
    func getMockData() {
        repo.getMockData()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { (value) in
                self.ListProduct.accept(value)
            }, onFailure: { (error) in
                self.alertError.onNext(error.localizedDescription)
            })
    }
    func clearData() {
        let empty = [ProductPromo]()
        ListProduct.accept(empty)
    }
    
}
