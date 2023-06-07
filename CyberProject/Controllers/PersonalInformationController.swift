//
//  PersonalInformationController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit
import SnapKit
import Encryption
import CommonCrypto

class AESWrapper {
    private let aes: AES

    init(aesKey: AESKey) {
        self.aes = .init(key: aesKey, options: CCOptions(ccPKCS7Padding))
    }

    func encrypt(message: String) -> String {
        let decrypted = try! DecryptedValue(decryptedString: message)
        let encrypted = try! decrypted.encrypted(using: aes)
        return encrypted.base64String
    }

    func decrypt(message: String) -> String {
        let encrypted = try! EncryptedValue(encryptedString: message)
        let decrypted = try! encrypted.decrypted(using: aes)
        return try! decrypted.string()
    }
}


class PersonalInformationController: UIViewController {
    
    let textFieldName = UITextField.createTextField(placeholder: "Write your name")
    let textFieldSurname = UITextField.createTextField(placeholder: "Write your surname")
    
    let aesWrapper: AESWrapper!
    
    let aesKey = AESKey(
            secret: "t6w9z$C&F)J@NcRf",
            initialVector: "6CF105AB-4D16-44"
        )
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let showDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Data", for: .normal)
        button.addTarget(self, action: #selector(showDataButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(aesKey: AESKey) {
        self.aesWrapper = AESWrapper(aesKey: aesKey)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(saveButton)
        view.addSubview(showDataButton)
        configureConstrait()
    }
    
    @objc private func saveButtonTapped() {
        saveData()
    }
    
    @objc private func showDataButtonTapped() {
        let dataViewController = DataViewController()
        navigationController?.pushViewController(dataViewController, animated: true)
    }
    
    private func saveData() {
        let name = textFieldName.text ?? ""
        let surname = textFieldSurname.text ?? ""
        
        let encryptedName = aesWrapper.encrypt(message: name)
        let encryptedSurname = aesWrapper.encrypt(message: surname)
        
        let personalInfo = PersonalInfo()
        personalInfo.encryptedName = encryptedName
        personalInfo.encryptedSurname = encryptedSurname
        
        RealmManager.shared.saveData(data: personalInfo)
    }
    
    private func configureConstrait() {
        view.addSubview(textFieldName)
        textFieldName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        view.addSubview(textFieldSurname)
        textFieldSurname.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldSurname.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        view.addSubview(showDataButton)
        showDataButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
        }
    }
}

class DataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Implement your logic to display the saved data here
    }
}

