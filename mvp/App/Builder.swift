//
//  Builder.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import Foundation

protocol Builder: AnyObject {
    func createMain() -> ViewController
}

class MainBuilders: Builder {
    func createMain() -> ViewController {
        let view = ViewController()
//        let presenter = MainPresenter(view: any MainViewProtocol, button: any CustomButtonProtocol)
        return view
    }
}
