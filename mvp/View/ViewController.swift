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
    
    let navItem = UINavigationItem(title: "title")
    
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
    
    private lazy var alertButton = CustomButton(type: .showAlert)
    private lazy var upButton = CustomButton(type: .upProgress)
    private lazy var downButton = CustomButton(type: .downPorgess)
    private lazy var backgrondButton = CustomButton(type: .changeBackground)

//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Nav bar"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "1/10")
        
        setupUI()
        setupConstraints()
        setActionForButton()
    }
    
    // MARK: - Actions
    @objc private func tapedButton(_ sender: CustomButton) {
        presenter.showNewButtonColor(button: sender)
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(progressBar)
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(alertButton)
        vStack.addArrangedSubview(upButton)
        vStack.addArrangedSubview(downButton)
        vStack.addArrangedSubview(backgrondButton)
    }
    
    private func setActionForButton() {
        alertButton.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
        backgrondButton.addTarget(self, action: #selector(tapedButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            alertButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            alertButton.heightAnchor.constraint(equalToConstant: 80),
            
            upButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            upButton.heightAnchor.constraint(equalToConstant: 80),
            
            downButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            downButton.heightAnchor.constraint(equalToConstant: 80),
            
            backgrondButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            backgrondButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

extension ViewController: MainViewProtocol {
    func setColorButtom(button: UIButton, color: UIColor) {
        button.backgroundColor = color
    }
    
    
}
