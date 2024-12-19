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
    init(button: MainViewProtocol)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var button: MainViewProtocol?
    
    required init(button: MainViewProtocol) {
        self.button = button
    }
    
    
}
