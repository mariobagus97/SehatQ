//
//  RootViewController.swift
//  Boilerplate-Mvvm
//
//  Created by Muhammad Ario Bagus on 13/05/21.
//

import UIKit

class RootViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
        self.delegate = self
    }
    
    @objc func setupTab() {
      let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
      let homeNav = UINavigationController(rootViewController: homeVC)
      homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icRedLove"), selectedImage: UIImage(named: "icLoveBW"))
    
        
        let feedVC = UIViewController()
        feedVC.view.backgroundColor = UIColor.red
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "icRedLove"), selectedImage: UIImage(named: "icLoveBW"))
       
        
        let cartVC = UIViewController()
        cartVC.view.backgroundColor = UIColor.green
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "icRedLove"), selectedImage: UIImage(named: "icLoveBW"))
     

        let profileVC = PurchaseHistoryViewController(nibName: "PurchaseHistoryViewController", bundle: nil)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "icRedLove"), selectedImage: UIImage(named: "icLoveBW"))
        
      
      self.viewControllers = [homeNav,feedVC,cartVC,profileVC]
    }
}

extension RootViewController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is PurchaseHistoryViewController {
            let vc = PurchaseHistoryViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
            return false
        } else {
            return true
        }
    }
}
