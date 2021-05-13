//
//  HomeViewController.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 12/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController<HomeViewModel> {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var tableProduct: UITableView!
    var searchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getHome()
        setupBinding()
        setupTableView()
        
        tableProduct.rx
            .modelSelected(ProductPromo.self)
            .subscribe(onNext:  { value in
                self.gotoProductDetail(product: value)
            })
            .disposed(by: disposeBag)
    }
    
    func setupNavigationBar(){
        self.searchBar.delegate = self
        searchBar.placeholder = "RTX 3080..."
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icLoveBW")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    private func setupBinding(){
        categoriesCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryCell.self))
        
        viewModel.ListProduct.bind(to: tableProduct.rx.items(cellIdentifier: "cellId", cellType: ProductCell.self)) { (row,item,cell) in
            cell.lblName.text = item.title
            cell.imgProduct.loadImage(fromURL: item.imageURL)
            cell.btnWishlist.setImagefromInt(value: item.loved)
        }
            .disposed(by: disposeBag)
        
        viewModel.ListCategory
            .bind(to: categoriesCollectionView.rx.items(cellIdentifier: "CategoryCell", cellType: CategoryCell.self)) {  (row,data,cell) in
                cell.lblName.text = data.name
                cell.imgCategory.loadImage(fromURL: data.imageURL)
        }.disposed(by: disposeBag)
    }
    
    func setupTableView() {
        tableProduct.rowHeight = UITableView.automaticDimension
        tableProduct.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        tableProduct.reloadData()
    }
}

extension HomeViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
        return false
    }
}
