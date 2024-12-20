//
//  ButtonType.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import Foundation

enum MyButtonType {
    case showAlert
    case upProgress
    case downPorgess
    case changeBackground
}

/*
 - Для реализации кнопок наследуемся от **UIButton**. В инициализаторе наследника передаем параметр типа **enum** **ButtonType**, в соответствии с которым конфигурируем цвета.
 - Работу заполняющегося бара реализовать через **CALayer**.
 - По нажатию на кнопку смены цвета менять **backgroundColor** контроллера на рандомный цвет.
 - Для создания конфетти использовать **CAEmitterLayer**.
 - По нажатию на кнопку должна срабатывать анимация**:**
 */
