import UIKit
import SnapKit

class PhishingController: UIViewController {
    
    let phishingChecker = PhishingChecker()
    let urlTextField = UITextField()
    let resultLabel = UILabel()
    let checkButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        urlTextField.borderStyle = .roundedRect
        urlTextField.placeholder = "Enter a URL"
        self.view.addSubview(urlTextField)
        
        self.view.addSubview(resultLabel)
        
        checkButton.setTitle("Check URL", for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        self.view.addSubview(checkButton)
    }
    
    func setupConstraints() {
        urlTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }

        resultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(urlTextField.snp.bottom).offset(60)
            make.leading.trailing.equalTo(urlTextField)
            make.height.equalTo(40)
        }

        checkButton.snp.makeConstraints { (make) in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.leading.trailing.height.equalTo(urlTextField)
        }
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
