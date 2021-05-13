//
//  ProductItemCell.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 14/05/21.
//

import UIKit

class ProductItemCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
        baseView.layer.masksToBounds = false
        baseView.layer.shadowOpacity = 0.23
        baseView.layer.shadowRadius = 4
        baseView.layer.shadowOffset = CGSize(width: 0, height: 0)
        baseView.layer.shadowColor = UIColor.black.cgColor

        baseView.backgroundColor = .white
        baseView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
