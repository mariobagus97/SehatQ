//
//  ProductDetailViewController.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import UIKit

class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    
    private var product : ProductPromo
    private var isSelected = false
    
    init(product : ProductPromo) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        btnBack.rx.tap
            .bind {
                if (self.navigationController?.viewControllers == nil){
                    self.dismiss(animated: false, completion: nil)
                } else {
                    self.navigationController?.popViewController(animated: false)
                }
            }
            .disposed(by: disposeBag)
        
        btnWishlist.rx.tap
            .bind(onNext: { [self] (value) in
                product.loved = product.loved == 0 ? 1 : 0
                btnWishlist.setImagefromInt(value: product.loved)
                print(product.loved)
            })
            .disposed(by: disposeBag)
        
        btnBuy.rx.tap
            .bind { [self] in
                viewModel.BuyProduct(product: product)
                self.showAlert(title: "Success", message: "Items Purchased")
            }
            .disposed(by: disposeBag)
        
        btnShare.rx.tap
            .bind {
                let message = self.product.title + " only \(self.product.price) Grab it NOW !!!"
                        //Set the link to share.
                        if let link = NSURL(string: "http://ariobagus.com")
                        {
                            let objectsToShare = [message,link] as [Any]
                            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                            activityVC.excludedActivityTypes = [
                                UIActivity.ActivityType.print,
                                UIActivity.ActivityType.addToReadingList,
                                UIActivity.ActivityType.postToFacebook
                            ]
                            self.present(activityVC, animated: true, completion: nil)
                        }
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupView(){
            lblName.text = product.title
            btnWishlist.setImagefromInt(value: product.loved)
            txtDescription.text = product.productPromoDescription
            imgProduct.loadImage(fromURL: product.imageURL)
            lblPrice.text = product.price
    }
}



