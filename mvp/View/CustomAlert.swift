//
//  CustomAlert.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 20.01.2025.
//

import UIKit

final class CustomAlert: UIView {
//    MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let goButton: UIButton = {
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
        titleLabel.text = "Введите ваше имя"
        textField.placeholder = "введите ваше имя..."
        goButton.setTitle("Готово", for: .normal)
    }
}

// MARK: - Extensions Constraints
extension CustomAlert {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            goButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            goButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            goButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            goButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
