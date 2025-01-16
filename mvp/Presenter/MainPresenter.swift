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
    func setProgress(value: CGFloat)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, data: ModelData)
    var data: ModelData { get set }
    func tappedChangeBackgroundButton()
    func tappedChangeProgressButton(id: String?)
}

// MARK: - Presenter
class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    var data: ModelData
    var progress: CGFloat
    
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
        if id == data.addProgress {
            progress = min((progress + 0.1), 1.0)
        } else if id == data.reduceProgress {
            progress = min((progress - 0.1), 0.0)
        }
        view.setProgress(value: progress)
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
