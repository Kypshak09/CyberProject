//
//  UITextField.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 16.05.2023.
//

import UIKit

extension UITextField {
    
    static func createTextField(placeholder: String) -> UITextField {
        let textField: UITextField = {
            let text = UITextField()
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            text.leftView = leftView
            text.leftViewMode = .always
            text.placeholder = placeholder
            text.layer.cornerRadius = 15
            text.backgroundColor = .systemGray2
            return text
        }()
        return textField
    }
}
