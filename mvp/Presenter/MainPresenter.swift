//
//  MainPresenter.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
//   обработка данных в presenter и отдаем View
    func setColorButtom(button: UIButton, color: UIColor)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol)
    func showNewButtonColor(button: UIButton)
}






class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    
    required init(view: any MainViewProtocol) {
        self.view = view
    }
    
    func showNewButtonColor(button: UIButton) {
        view.setColorButtom(button: button, color: .black)
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
