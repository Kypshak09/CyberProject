//
//  PersonalInformationController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit
import SnapKit
class PersonalInformationController: UIViewController {
    
    let textFieldName = UITextField.createTextField(placeholder: "Write your name")
    let textFieldSurname = UITextField.createTextField(placeholder: "Write your surname")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureConstrait() {
        view.addSubview(textFieldName)
        textFieldName.snp.makeConstraints { make in
            make.top
        }
    }
}
