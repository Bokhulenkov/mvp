//
//  Builder.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import UIKit

protocol Builder: AnyObject {
    static func createMain() -> UIViewController
}

class MainBuilders: Builder {
    static func createMain() -> UIViewController {
        let view = ViewController()
#warning("в момент загрузки view не применяются изменения для progress - ModelData(progress: 0.5)")
        let data = ModelData(progress: 0.0, addProgress: K.upProgress, reduceProgress: K.downProgress)
        let presenter = MainPresenter(view: view, data: data)
        view.presenter = presenter
        return view
    }
}


