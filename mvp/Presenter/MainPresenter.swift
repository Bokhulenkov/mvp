//
//  MainPresenter.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

// MARK: - Protocol view
protocol MainViewProtocol: AnyObject {
    func setRandomBackground(color: UIColor)
    func setProgress(progress: CGFloat, value: Int)
}

// MARK: - Presenter protocol
protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, data: ModelData)
    var data: ModelData { get set }
    func tappedAlertButton(vc: UIViewController)
    func tappedChangeBackgroundButton()
    func tappedChangeProgressButton(id: String?)
    func tappedShowConfetti(view: UIView)
}

// MARK: - Presenter
class MainPresenter: MainViewPresenterProtocol {
    
    // MARK: - Properties
    let view: MainViewProtocol
    var data: ModelData
    var progress: CGFloat
    var valueProgress = 0
    
    // MARK: - Init
    required init(view: MainViewProtocol, data: ModelData) {
        self.view = view
        self.data = data
        self.progress = data.progress
    }
    
    // MARK: - Methods
    func tappedAlertButton(vc: UIViewController) {
        let alertController = UIAlertController(title: K.alertTitle, message: nil, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: K.alertButtonLabel, style: .default) {_ in
            let userName = alertController.textFields?[0].text
            print(userName ?? "nil")
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Имя"
            textField.autocapitalizationType = .words
            textField.returnKeyType = .go
            textField.textContentType = .username
        }
        
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true) {
        }
    }
    
    func tappedChangeBackgroundButton() {
        view.setRandomBackground(color: UIColor.random)
    }
    
    func tappedChangeProgressButton(id: String?) {
        data.progress = progress
        if id == data.addProgress && valueProgress < 10 {
            progress = min((progress + 0.1), 1.0)
            valueProgress += 1
        } else if id == data.reduceProgress && valueProgress > 0 {
            progress = max((progress - 0.1), 0.0)
            valueProgress -= 1
        } else {
            progress = 0
            valueProgress = 0
        }
        view.setProgress(progress: progress, value: valueProgress)
    }

    func tappedShowConfetti(view: UIView) {
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterPosition = CGPoint(x: view.center.x, y: -90)
        emitterLayer.emitterShape = .line
        emitterLayer.emitterSize = CGSize(width: view.frame.width, height: 1)
        
        view.layer.addSublayer(emitterLayer)
        
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 50
        cell.velocity = 100
        cell.velocityRange = 2
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.5
        cell.scaleRange = 0.7
        cell.scaleSpeed = -0.07
        
        cell.contents = UIImage(named: K.confetti)?.cgImage
        emitterLayer.emitterCells = [cell]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            emitterLayer.removeFromSuperlayer()
        }
    }
}
