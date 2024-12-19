//
//  ViewController.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

final class ViewController: UIViewController {
    
//    MARK: - Properties
    var presenter: MainViewPresenterProtocol!
    
    private lazy var progressBar: UIProgressView = {
        let element = UIProgressView()
        element.progress = 0.5
        element.progressTintColor = .blue
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var vStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 20
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(progressBar)
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(CustomButton(type: .showAlert))
        vStack.addArrangedSubview(CustomButton(type: .upProgress))
        vStack.addArrangedSubview(CustomButton(type: .downPorgess))
        vStack.addArrangedSubview(CustomButton(type: .changeBackground))
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            vStack.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
