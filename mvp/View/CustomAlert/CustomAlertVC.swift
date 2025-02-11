//
//  CustomAlertVC.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 05.02.2025.
//

import UIKit

final class CustomAlertVC: UIViewController {
    //    MARK: - Properties
    private let alertView = CustomAlertView()
    
    // MARK: - LifeCycle
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
    }
}
