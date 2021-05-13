//
//  HomeService.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import Foundation
import RxSwift

class HomeService {
    
    func GetHeroes() -> Single<HomeResponse> {
        return UrlBuilder<HomeResponse>()
            .SetUrl(urlSegment: "/home")
            .SetBasicHeader()
            .Execute(httpMethod: .get)
            .asSingle()
    }
}
