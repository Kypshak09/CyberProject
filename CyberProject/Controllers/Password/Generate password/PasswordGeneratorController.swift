//
//  PasswordGeneratorController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit
import SnapKit

class PasswordGeneratorController: UIViewController {
    
    private var password = ""
    
    let textFieldName = UITextField.createTextField(placeholder: "Write your name")
    let textFieldAge = UITextField.createTextField(placeholder: "Write you age")
    let buttonPassword = UIButton.createButton(name: "Generate")
    
    let label = UILabel.createLabel(name: "Your password:", fontSize: 20, font: "")
    let passwordLabel = UILabel.createLabel(name: "", fontSize: 20, font: "" )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Password Generator"
        configureConstrait()
    }
    
    @objc func generatePassword() {
        password = textFieldName.text ?? "" + String(textFieldAge.text ?? "")
        password = String(password.shuffled())
        
        let passwordCharacters = Array(password)
            var newCharacters = [String]()
            for (index, character) in passwordCharacters.enumerated() {
                if index % 2 == 0 {
                    newCharacters.append(String(character.unicodeScalars.first!.value))
                } else {
                    newCharacters.append(String(character))
                }
            }
        
        let newPassword = newCharacters.joined()
        
        passwordLabel.text = String(newPassword)
    }
    
    
    private func configureConstrait() {
        buttonPassword.addTarget(self, action: #selector(generatePassword), for: .touchUpInside)
        
        view.addSubview(textFieldName)
        textFieldName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
            
        }
        view.addSubview(textFieldAge)
        textFieldAge.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        view.addSubview(buttonPassword)
        buttonPassword.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldAge.snp.bottom).offset(100)
            make.height.width.equalTo(100)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(100)
            make.top.equalTo(buttonPassword.snp.bottom).offset(50)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing).offset(20)
            make.top.equalTo(buttonPassword.snp.bottom).offset(50)
        }
        
    }
}
