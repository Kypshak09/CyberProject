//
//  UIButton.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 16.05.2023.
//

import UIKit

extension UIButton {
    static func createButton(name: String) -> UIButton {
        let button: UIButton = {
            let button = UIButton()
            button.setTitle(name, for: .normal)
            button.tintColor = .black
            button.backgroundColor = .cyan
            return button
        }()
        return button
    }
}
