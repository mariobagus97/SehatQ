//
//  BaseViewModel.swift
//  Crypto
//
//  Created by Muhammad Ario Bagus on 28/04/21.
//

import Foundation
import RxSwift
import RxCocoa


class BaseViewModel : NSObject {
    
    var alertError :  PublishSubject<String> = PublishSubject()
    var isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func showLoading() {
        isLoading.accept(true)
    }
    func hideLoading() {
        isLoading.accept(false)
    }
    
}

