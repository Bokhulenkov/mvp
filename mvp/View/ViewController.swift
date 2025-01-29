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
    private var tapButton = true
    
    private lazy var progressBar: ProgressBarView = {
        let progressBar = ProgressBarView()
        progressBar.backgroundColorLayer = .systemGray
        progressBar.progressColor = .systemBlue
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
//    создали кнопки
    private lazy var alertButton = CustomButton(type: .showAlert)
    private lazy var upButton = CustomButton(type: .upProgress)
    private lazy var downButton = CustomButton(type: .downProgress)
    private lazy var backgrondButton = CustomButton(type: .changeBackground)
    
//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = progressBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(K.progressValue)/10")
        
        setupUI()
        
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.translatesAutoresizingMaskIntoConstraints = false
        backgrondButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        setActionForButton()
    }
    
    // MARK: - Actions
    @objc private func changeColor(_ sender: CustomButton) {
        presenter.tappedChangeBackgroundButton()
        sender.tapedAnimation(sender, from: downButton)
    }
    
    @objc private func upProgress(_ sender: UIButton) {
        presenter.tappedChangeProgressButton(id: sender.accessibilityIdentifier)
        
    }
    
    @objc private func downProgress(_ sender: UIButton) {
        presenter.tappedChangeProgressButton(id: sender.accessibilityIdentifier)
        sender.showAnimation {
            self.tapButton.toggle()
            sender.layer.shadowOffset = self.tapButton ? CGSize(width: 1, height: 1) : CGSize(width: 3, height: 4)
            sender.layer.opacity = self.tapButton ? 0.7 : 1
        }
    }
    
    @objc private func tappedAllert() {
//        presenter.tappedShowConfetti(view: self.view)
        presenter.tappedAlertButton(vc: self)
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

// MARK: - Extensions
extension ViewController: MainViewProtocol {
    func setProgress(progress: CGFloat, value: Int) {
        progressBar.progress = progress
        self.navigationItem.rightBarButtonItem?.title = "\(value)/10"
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

extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
    
    func tapedAnimation(_ sender: UIButton, from button: UIButton ) {
        UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse]) {
//            sender.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 90).isActive = true
            self.layoutIfNeeded()
        }
//        completion: { <#Bool#> in
//            <#code#>
//        }



    }
}
