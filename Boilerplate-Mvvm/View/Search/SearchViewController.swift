//
//  SearchViewController.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 13/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController<SearchViewModel> {

    @IBOutlet weak var productTableView: UITableView!
    var searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        setupTableView()
        productTableView.keyboardDismissMode = .onDrag
        
        viewModel.ListProduct.bind(to: productTableView.rx.items(cellIdentifier: "cellId", cellType: ProductItemCell.self)) { (row,item,cell) in
            cell.lblName.text = item.title
            cell.imgProduct.loadImage(fromURL: item.imageURL)
            cell.lblPrice.text = item.price
        }
            .disposed(by: disposeBag)
        
        productTableView.rx
            .modelSelected(ProductPromo.self)
            .subscribe(onNext:  { value in
                self.gotoProductDetail(product: value)
            })
            .disposed(by: disposeBag)
    }
    
    func setupTableView() {
        productTableView.rowHeight = UITableView.automaticDimension
        productTableView.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: "cellId")
        productTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icBack")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backTapped))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    @objc func backTapped(){
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            viewModel.clearData()
        } else {
            viewModel.getMockData()
        }
    }
}

