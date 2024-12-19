//
//  MainPresenter.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 19.12.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
   
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, button: CustomButtonProtocol)
}

class MainPresenter: MainViewPresenterProtocol {
    var view: MainViewProtocol
    var button: CustomButtonProtocol
    
    required init(view: any MainViewProtocol, button: any CustomButtonProtocol) {
        self.view = view
        self.button = button
    }
}
