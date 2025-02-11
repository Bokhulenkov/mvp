//
//  CustomAlert.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 20.01.2025.
//

import UIKit

protocol CustomAlertProtocol: AnyObject {
    func didCloseAlert()
}

final class CustomAlertView: UIView {
    //    MARK: - Properties
    weak var delegate: CustomAlertProtocol!
    
    //    MARK: - Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .left
        textField.textColor = .systemBlue
        textField.backgroundColor = .lightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let goButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //    MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setUI() {
        [
            titleLabel,
            textField,
            goButton
        ].forEach {
            addSubview($0)
        }
        titleLabel.text = K.alertTitle
        textField.placeholder = "\(K.alertTitle)..."
        goButton.setTitle(K.alertButtonLabel, for: .normal)
        goButton.addTarget(self, action: #selector(tapedGoButton), for: .touchUpInside)
    }
    
    @objc func tapedGoButton(vc: UIViewController) {
        delegate.didCloseAlert()
        print("tap")
    }
}

// MARK: - Extensions Constraints
extension CustomAlertView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            goButton.widthAnchor.constraint(equalToConstant: 150),
            goButton.heightAnchor.constraint(equalToConstant: 40),
            goButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goButton.bottomAnchor.constraint(greaterThanOrEqualTo: centerYAnchor, constant: 100)
        ])
    }
}
