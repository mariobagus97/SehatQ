//
//  LocalDB.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 14/05/21.
//

import Foundation
import RealmSwift

class AllProduct: Object {
    var mockProduct = List<Product>()
    var productPurchase = List<Product>()
}

class Product : Object {
    @objc dynamic var id: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var productPromoDescription : String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var loved: Int = 0
}
