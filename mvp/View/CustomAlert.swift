//
//  CustomAlert.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 20.01.2025.
//

import UIKit

class CustomAlert: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    let goButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
}
