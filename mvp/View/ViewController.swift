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
    private lazy var downButton = CustomButton(type: .downProgress)
    private lazy var backgrondButton = CustomButton(type: .changeBackground)
    
//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = progressBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(K.progressValue)/10")
        
        setupUI()
        setupConstraints()
        setActionForButton()
    }
    
    // MARK: - Actions
    @objc private func changeColor(_ sender: CustomButton) {
        presenter.tappedChangeBackgroundButton()
        sender.tapedAnimation(sender)
        
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
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(alertButton)
        vStack.addArrangedSubview(upButton)
        vStack.addArrangedSubview(downButton)
        vStack.addArrangedSubview(backgrondButton)
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

public extension UIView {
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
    
    func tapedAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse]) {
            sender.translatesAutoresizingMaskIntoConstraints = false
            sender.heightAnchor.constraint(equalToConstant: 40).isActive = true
            sender.layoutIfNeeded()
        }
//        completion: { <#Bool#> in
//            <#code#>
//        }



    }
}
