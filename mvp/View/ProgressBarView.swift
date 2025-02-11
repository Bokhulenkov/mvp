//
//  LineProgressView.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 09.01.2025.
//

import UIKit

final class ProgressBarView: UIView {
    // MARK: - Properties
    
    public var progress: CGFloat = 0.0 {
        didSet {
            updateProgress()
        }
    }
    
    public var progressColor: UIColor = .systemBlue {
        didSet {
            progressLayer.backgroundColor = progressColor.cgColor
        }
    }
    
    public var backgroundColorLayer: UIColor = .systemGray {
        didSet {
            backgroundLayer.backgroundColor = backgroundColorLayer.cgColor
        }
    }
    
    private let progressLayer = CALayer()
    private let backgroundLayer = CALayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func updateProgress() {
        let width = bounds.width * progress
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        progressLayer.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        CATransaction.commit()
    }
    
    private func setupLayers() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = self.bounds
        backgroundLayer.cornerRadius = bounds.height / 2
        progressLayer.cornerRadius = bounds.height / 2
        updateProgress()
    }
}
