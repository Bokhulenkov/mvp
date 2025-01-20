//
//  MainPresenter.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    //   обработка данных в presenter и отдаем View
    func setRandomBackground(color: UIColor)
    func setProgress(progress: CGFloat, value: Int)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, data: ModelData)
    var data: ModelData { get set }
    func tappedChangeBackgroundButton()
    func tappedChangeProgressButton(id: String?)
#warning("здесь view это UIView или оно тоже должно быть абстрактным view")
    func tappedShowConfetti(view: UIView)
}

// MARK: - Presenter
class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    var data: ModelData
    var progress: CGFloat
    var valueProgress = 0
    
    required init(view: MainViewProtocol, data: ModelData) {
        self.view = view
        self.data = data
        self.progress = data.progress
    }
    
    func tappedChangeBackgroundButton() {
        view.setRandomBackground(color: .random)
    }
    
    func tappedChangeProgressButton(id: String?) {
        data.progress = progress
        if id == data.addProgress && valueProgress < 10 {
            progress = min((progress + 0.1), 1.0)
            valueProgress += 1
            
        } else if id == data.reduceProgress && valueProgress > 0 {
            progress = max((progress - 0.1), 0.0)
            valueProgress -= 1
        }
        view.setProgress(progress: progress, value: valueProgress)
    }
    
    func tappedShowConfetti(view: UIView) {
#warning("На сколько хорошая практика передавать конкретно view или тут тоже надо передавать протокол")
        
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
    }
}

extension UIColor {
    static var random: UIColor {
        return .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}

/*
 - Реализовать приложение с кастомными UI элементами. По макету: [**https://www.figma.com/file/pSDARV8tp3yAvcTkH07r50/Untitled?node-id=0%3A1**](https://www.figma.com/file/pSDARV8tp3yAvcTkH07r50/Untitled?node-id=0%3A1)
 - Для реализации кнопок наследуемся от **UIButton**. В инициализаторе наследника передаем параметр типа **enum** **ButtonType**, в соответствии с которым конфигурируем цвета.
 - Работу заполняющегося бара реализовать через **CALayer**.
 - По нажатию на кнопку смены цвета менять **backgroundColor** контроллера на рандомный цвет.
 - Для создания конфетти использовать **CAEmitterLayer**.
 - По нажатию на кнопку должна срабатывать анимация**:**
 */


// user тапнул, дергаем презентер - и запускаем анимацию
