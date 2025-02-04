//
//  Extensions.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 04.02.2025.
//

import UIKit

// MARK: - UIColor
extension UIColor {
    static var random: UIColor {
        return .init(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}
#warning("или надо по хорошему их в presenter отправить")
// MARK: - UIView
extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
            }) {  (done) in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: .curveLinear,
                    animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    }) { [weak self] (_) in
                        self?.isUserInteractionEnabled = true
                        completionBlock()
                    }
            }
    }
    
    func tapedAnimation(_ sender: UIButton) {
#warning("из за чего autoreverse не всегда возвращает кнопку, а так же вызывает иногда подергивание")
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseInOut]
        ) {
            sender.transform = CGAffineTransform(translationX: 0, y: 2)
            sender.layer.shadowOffset = CGSize(width: 2, height: 1)
        }
        completion: {_ in
            sender.transform = CGAffineTransform(translationX: 0, y: 0)
            sender.layer.shadowOpacity = 0.8
            sender.layer.shadowOffset = CGSize(width: 3, height: 4)
            sender.layer.shadowRadius = 3
        }
    }
}
