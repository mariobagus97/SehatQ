//
//  ProductDetailViewModel.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailViewModel: BaseViewModel {
    
    private var repo: IProductDetailRepository
    init(repo : IProductDetailRepository) {
        self.repo = repo
    }
    
    
    var product : PublishSubject<ProductPromo> = PublishSubject()
    
    func BuyProduct(product : ProductPromo) {
        repo.buyProduct(product: product)
    }
}
