//
//  BaseViewController.swift
//  Crypto
//
//  Created by Muhammad Ario Bagus on 28/04/21.
//

import UIKit
import RxSwift
import RxCocoa


class BaseViewController<T : BaseViewModel>: UIViewController {
    internal let disposeBag = DisposeBag()
    internal var viewModel:T!
    internal let refreshControl = UIRefreshControl()
    private var container = Container()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = container.getViewModel(viewModel: T.self)
       
               viewModel.alertError
                   .asObservable()
                   .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                .observe(on: MainScheduler.instance)
                   .subscribe(onNext: { (msgError) in
                       if !msgError.isEmpty{
                           self.showAlert(title: "Kesalahan", message: msgError)
                       }
                   }).disposed(by: disposeBag)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }
    
    func showAlert(title : String, message : String) {
        let uialert = UIAlertController(title: title, message: message
                                   , preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
    }
    
    func gotoProductDetail(product : ProductPromo) {
       let vc = ProductDetailViewController(product: product)
       vc.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(vc, animated: false)
   }
}
