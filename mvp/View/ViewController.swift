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
    
    private lazy var progressBar: ProgressBarView = {
        let progressBar = ProgressBarView()
        progressBar.backgroundColorLayer = .systemGray
        progressBar.progressColor = .systemBlue
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private lazy var vStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 20
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
//    создали кнопки
    private lazy var alertButton = CustomButton(type: .showAlert)
    private lazy var upButton = CustomButton(type: .upProgress)
    private lazy var downButton = CustomButton(type: .downPorgess)
    private lazy var backgrondButton = CustomButton(type: .changeBackground)
    
//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = progressBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "1/10")
        
        setupUI()
        setupConstraints()
        setActionForButton()
    }
    
    // MARK: - Actions
    @objc private func changeColor(_ sender: CustomButton) {
        presenter.tappedChangeBackgroundButton()
    }
    
    @objc private func upProgress() {
        presenter.tappedChangeProgressButton()
    }
    
    @objc private func tappedProgerss() {
        
    }
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(alertButton)
        vStack.addArrangedSubview(upButton)
        vStack.addArrangedSubview(downButton)
        vStack.addArrangedSubview(backgrondButton)
    }
    
    private func setActionForButton() {
        backgrondButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(upProgress), for: .touchUpInside)
    }
    
    
}

// MARK: - Extensions
extension ViewController: MainViewProtocol {
    func setProgress(value: CGFloat) {
        progressBar.progress = value
    }
    
    func setRandomBackground(color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - Settings Constraints
extension ViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            
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
