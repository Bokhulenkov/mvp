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
        
        return view
    }
}
