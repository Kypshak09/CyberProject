//
//  UILabel.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import Foundation
import UIKit

extension UILabel {
    static func createLabel(name: String?, fontSize: Int, font: String?) -> UILabel{
        let label: UILabel = {
            let label = UILabel()
            label.text = "\(name ?? "")"
            label.font = UIFont(name: font ?? "Arial", size: CGFloat(fontSize))
            return label
        }()
        return label
    }
    
}
