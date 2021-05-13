//
//  Extensions.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
}

extension UIButton {
    func setImagefromInt (value : Int ) {
        if value == 0 {
            self.setImage(UIImage(named: "icLoveBW")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            self.setImage(UIImage(named: "icRedLove")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
}


extension ProductPromo {
    func ToProduct()-> Product{
        let product = Product()
        product.id = self.id
        product.imageURL = self.imageURL
        product.title = self.title
        product.productPromoDescription = self.productPromoDescription
        product.price = self.price
        product.loved = self.loved
        return product
    }
}

extension Product {
    func ToProductPromo()-> ProductPromo{
        return ProductPromo(id: self.id, imageURL: self.imageURL, title: self.title, productPromoDescription: self.productPromoDescription, price: self.price, loved: self.loved)
    }
}
