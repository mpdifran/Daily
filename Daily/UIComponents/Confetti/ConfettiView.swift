//
//  ConfettiView.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import UIKit

private enum Constants {
    static let defaultEmissionTime: TimeInterval = 5
}

// MARK: - ConfettiView

class ConfettiView: UIView {

    private enum Key {
        static let animationLayer = "animation"
    }

    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: Public Methods

extension ConfettiView {

    func emit() {
        emit(with: [.circle])
    }

    func emit(with shapes: [Particle.Shape], for duration: TimeInterval = Constants.defaultEmissionTime) {
        let layer = ConfettiEmitterLayer()
        layer.configure(with: shapes)
        emit(using: layer, for: duration)
    }

    func emit(with particles: [Particle], for duration: TimeInterval = Constants.defaultEmissionTime) {
        let layer = ConfettiEmitterLayer()
        layer.configure(with: particles)
        emit(using: layer, for: duration)
    }

    func emit(using layer: ConfettiEmitterLayer, for duration: TimeInterval) {
        layer.frame = superview?.bounds ?? bounds
        layer.needsDisplayOnBoundsChange = true
        layer.masksToBounds = false
        self.layer.addSublayer(layer)

        guard duration.isFinite else { return }

        let animation = CAKeyframeAnimation(keyPath: #keyPath(CAEmitterLayer.birthRate))
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.values = [1, 0, 0]
        animation.keyTimes = [0, 0.5, 1]
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            let transition = CATransition()
            transition.delegate = self
            transition.type = .fade
            transition.duration = 1
            transition.timingFunction = CAMediaTimingFunction(name: .easeOut)
            transition.setValue(layer, forKey: Key.animationLayer)
            transition.isRemovedOnCompletion = false

            layer.add(transition, forKey: nil)

            layer.opacity = 0
        }
        layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
}

// MARK: CAAnimationDelegate Mwthods

extension ConfettiView: CAAnimationDelegate {

    func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        if let layer = animation.value(forKey: Key.animationLayer) as? CALayer {
            layer.removeAllAnimations()
            layer.removeFromSuperlayer()
        }
    }
}
