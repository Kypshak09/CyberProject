//
//  TabBarViewController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit
import SwiftUI
import Encryption

class TabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let settingsViewModel = SettingsViewModel()
        let passwordListViewModel = PasswordListViewModel()

        let passwordGeneratorView = PasswordGeneratorView(settings: settingsViewModel, passwordViewModel: passwordListViewModel)
        let passwordController = createTabBar(vc: UIHostingController(rootView: passwordGeneratorView), itemImage: "lock", itemName: "Password")
        
        
        let personalInformationController = createTabBar(vc: PersonalInformationController(aesKey: AESKey(
            secret: "t6w9z$C&F)J@NcRf",
            initialVector: "6CF105AB-4D16-44"
        )), itemImage: "person", itemName: "Personal")
         let phishingController = createTabBar(vc: PhishingController(), itemImage: "checkerboard.shield", itemName: "Phishing")
        
        viewControllers = [passwordController, personalInformationController, phishingController]
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
