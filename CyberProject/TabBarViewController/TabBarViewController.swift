//
//  TabBarViewController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
         let personalInformationController = createTabBar(vc: PersonalInformationController(), itemImage: "", itemName: "Personal")
         let phishingController = createTabBar(vc: PhishingController(), itemImage: "", itemName: "Phishing")
         let passwordController = createTabBar(vc: PasswordGeneratorController(), itemImage: "", itemName: "Password")
        
        viewControllers = [personalInformationController, passwordController, phishingController]
    }
    
    func createTabBar(vc: UIViewController, itemImage: String?, itemName: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: vc)
        controller.tabBarItem.title = itemName
        controller.tabBarItem.image = UIImage(systemName: itemImage ?? "")
        controller.navigationItem.title = itemName
        controller.navigationBar.scrollEdgeAppearance = controller.navigationBar.standardAppearance
        return controller
    }
}
