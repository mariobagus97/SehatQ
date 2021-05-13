//
//  PurchaseHistoryViewController.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 13/05/21.
//

import UIKit

class PurchaseHistoryViewController: BaseViewController<PurchaseHistoryViewModel> {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var purchaseHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.GetHistoryPurchase()
        
        purchaseHistoryTableView.rx
            .modelSelected(ProductPromo.self)
            .subscribe { (item) in
                self.gotoProductDetail(product: item)
            }
            .disposed(by: disposeBag)

        viewModel.ListProduct.bind(to: purchaseHistoryTableView.rx.items(cellIdentifier: "cellId", cellType: ProductItemCell.self)) { (row,item,cell) in
            cell.lblName.text = item.title
            cell.imgProduct.loadImage(fromURL: item.imageURL)
            cell.lblPrice.text = item.price
        }
            .disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func gotoProductDetail(product: ProductPromo) {
        let vc = ProductDetailViewController(product: product)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
    func setupTableView() {
        purchaseHistoryTableView.rowHeight = UITableView.automaticDimension
        purchaseHistoryTableView.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: "cellId")
        purchaseHistoryTableView.reloadData()   
    }
    
    func setupNavigationBar(){
        self.navItem.title = "Purchase History"
        
        self.navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icBack")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backTapped))
        
        self.navBar.setBackgroundImage(UIImage(), for: .default)
        self.navBar.shadowImage = UIImage()
        self.navBar.isTranslucent = true
    }
    
    @objc func backTapped(){
        dismiss(animated: false, completion: nil)
    }
}
