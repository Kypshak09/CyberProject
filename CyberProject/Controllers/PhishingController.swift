//
//  PhishingController.swift
//  CyberProject
//
//  Created by Amir Zhunussov on 29.04.2023.
//

import UIKit

class PhishingController: UIViewController {
    
    let phishingChecker = PhishingChecker()
    let urlTextField = UITextField()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        urlTextField.frame = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 40)
        urlTextField.borderStyle = .roundedRect
        urlTextField.placeholder = "Enter a URL"
        self.view.addSubview(urlTextField)
        
        
        resultLabel.frame = CGRect(x: 20, y: 250, width: self.view.frame.size.width - 40, height: 40)
        self.view.addSubview(resultLabel)
        
        
        let checkButton = UIButton(type: .system)
        checkButton.frame = CGRect(x: 20, y: 300, width: self.view.frame.size.width - 40, height: 40)
        checkButton.setTitle("Check URL", for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        self.view.addSubview(checkButton)
    }
    
    @objc func checkButtonTapped() {
        guard let url = urlTextField.text else { return }
        
        phishingChecker.phishingChecker(url){ (isPhishing) in
            DispatchQueue.main.async {
                if isPhishing {
                    self.resultLabel.text = "This URL is not trusted. Be careful!"
                    self.resultLabel.textColor = .red
                } else {
                    self.resultLabel.text = "This URL is trusted."
                    self.resultLabel.textColor = .green
                }
            }
        }
    }
}
