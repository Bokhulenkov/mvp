//
//  LineProgressView.swift
//  mvp
//
//  Created by Alexander Bokhulenkov on 09.01.2025.
//

import UIKit

final class ProgressBarView: UIView {
    // MARK: - Properties
    private let progressLayer = CALayer()
    private let backgroundLayer = CALayer()
    
    public var progress: CGFloat = 0.0 {
        didSet {
            updateProgress()
        }
    }
    
    var progressColor: UIColor = .systemBlue {
        didSet {
            progressLayer.backgroundColor = progressColor.cgColor
        }
    }
    
    var backgroundColorLayer: UIColor = .systemGray {
        didSet {
            backgroundLayer.backgroundColor = backgroundColorLayer.cgColor
        }
    }
    
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
        progressLayer.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
    }
    
    private func setupLayers() {
        backgroundLayer.borderColor = backgroundColorLayer.cgColor
        backgroundLayer.frame = self.bounds
        backgroundLayer.cornerRadius = self.bounds.height / 2
        layer.addSublayer(backgroundLayer)
        
        progressLayer.borderColor = progressColor.cgColor
        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: bounds.height)
        progressLayer.cornerRadius = bounds.height / 2
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
