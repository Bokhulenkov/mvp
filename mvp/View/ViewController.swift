//
//  ViewController.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

final class ViewController: UIViewController {
    //    MARK: - Properties
    public var presenter: MainViewPresenterProtocol!
    
    private var tapButton = true
    
    private lazy var progressBar: ProgressBarView = {
        let progressBar = ProgressBarView()
        progressBar.backgroundColorLayer = .systemGray
        progressBar.progressColor = .systemBlue
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private lazy var alertButton = CustomButton(type: .showAlert)
    private lazy var upButton = CustomButton(type: .upProgress)
    private lazy var downButton = CustomButton(type: .downProgress)
    private lazy var backgrondButton = CustomButton(type: .changeBackground)
    
    //    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = progressBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(resetProgress))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(K.progressValue)/10")
        navigationItem.leftBarButtonItem?.tintColor = .gray
        navigationItem.rightBarButtonItem?.tintColor = .gray
        
        setupUI()
        setActionForButton()
        
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.translatesAutoresizingMaskIntoConstraints = false
        backgrondButton.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    // MARK: - Actions
    @objc private func changeColor(_ sender: CustomButton) {
        sender.tapedAnimation(sender)
        presenter.tappedChangeBackgroundButton()
        presenter.tappedShowConfetti(view: self.view)
    }
    
    @objc private func upProgress(_ sender: UIButton) {
        sender.tapedAnimation(sender)
        presenter.tappedChangeProgressButton(id: sender.accessibilityIdentifier)
    }
#warning("сразу не отрабатывает, только после нескольних нажатий свет затемняется")
    @objc private func downProgress(_ sender: UIButton) {
        presenter.tappedChangeProgressButton(id: sender.accessibilityIdentifier)
        sender.showAnimation {
            self.tapButton.toggle()
            sender.layer.shadowOffset = self.tapButton ? CGSize(width: 1, height: 1) : CGSize(width: 3, height: 4)
            sender.layer.opacity = self.tapButton ? 0.7 : 1
        }
    }
    
    @objc private func tappedAllert(_ sender: UIButton) {
        sender.tapedAnimation(sender)
        presenter.tappedAlertButton(vc: self)
    }
    
    @objc private func resetProgress(_ sender: UIButton) {
        presenter.tappedChangeProgressButton(id: sender.accessibilityIdentifier)
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(alertButton)
        view.addSubview(upButton)
        view.addSubview(downButton)
        view.addSubview(backgrondButton)
    }
    
    private func setActionForButton() {
        backgrondButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(upProgress), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(downProgress), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(tappedAllert), for: .touchUpInside)
    }
}

// MARK: - Extensions MainViewProtocol
extension ViewController: MainViewProtocol {
    func setProgress(progress: CGFloat, value: Int) {
        progressBar.progress = progress
        self.navigationItem.rightBarButtonItem?.title = "\(value)/10"
    }
    
    func setRandomBackground(color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - Extensions Constraints
extension ViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            
            alertButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            alertButton.heightAnchor.constraint(equalToConstant: 80),
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            upButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            upButton.heightAnchor.constraint(equalToConstant: 80),
            upButton.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 20),
            upButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            downButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            downButton.heightAnchor.constraint(equalToConstant: 80),
            downButton.topAnchor.constraint(equalTo: upButton.bottomAnchor, constant: 20),
            downButton.centerXAnchor.constraint(equalTo: upButton.centerXAnchor),
            
            backgrondButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            backgrondButton.heightAnchor.constraint(equalToConstant: 80),
            backgrondButton.topAnchor.constraint(equalTo: downButton.bottomAnchor, constant: 20),
            backgrondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

