//
//  TabBarViewController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit
import SwiftUI

class TabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let settingsViewModel = SettingsViewModel()
        let passwordListViewModel = PasswordListViewModel()

        let passwordGeneratorView = PasswordGeneratorView(settings: settingsViewModel, passwordViewModel: passwordListViewModel)
        let passwordController = createTabBar(vc: UIHostingController(rootView: passwordGeneratorView), itemImage: "", itemName: "Password")
        
        
         let personalInformationController = createTabBar(vc: PersonalInformationController(), itemImage: "", itemName: "Personal")
         let phishingController = createTabBar(vc: PhishingController(), itemImage: "", itemName: "Phishing")
        
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
