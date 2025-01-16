//
//  CustomButton.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

final class CustomButton: UIButton {
    
    init(type: MyButtonType) {
        super.init(frame: .zero)
        configureButton(for: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton(for type: MyButtonType) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .showAlert:
            self.setTitle("Показать алерт", for: .normal)
            self.layer.cornerRadius = 20
            self.backgroundColor = .brown
        case .upProgress:
            self.setTitle("Увеличить прогресс", for: .normal)
            self.accessibilityIdentifier = K.upProgress
            self.layer.cornerRadius = 20
            self.backgroundColor = .red
        case .downProgress:
            self.setTitle("Уменьшить прогресс", for: .normal)
            self.layer.cornerRadius = 20
            self.accessibilityIdentifier = K.downProgress
            self.backgroundColor = .green
        case .changeBackground:
            self.setTitle("Изменить Background", for: .normal)
            self.layer.cornerRadius = 20
            self.backgroundColor = .systemPink
        }
    }
}
