//
//  ConfettiEmitterLayer.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import UIKit

private enum Constants {
    static var defaultParticleColors: [UIColor] = {
        return [
            UIColor(named: "DailyBlue")!,
            UIColor(named: "DailyTurquoise")!,
            UIColor(named: "DailyMint")!,
            UIColor(named: "DailyGreen")!
        ]
    }()

    static let particlesPerSecond: Float = 100
}

class ConfettiEmitterLayer: CAEmitterLayer {

    func configure(with shapes: [Particle.Shape]) {
        let particles = shapes.flatMap { (shape) -> [Particle] in
            return Constants.defaultParticleColors.map { (color) -> Particle in
                Particle.shape(shape, color)
            }
        }

        configure(with: particles)
    }

    func configure(with particles: [Particle]) {
        // This prevents more cells from being emitted per second when we add more particles.
        let birthRate: Float

        if particles.count == 0 {
            birthRate = 1
        } else {
            birthRate = Constants.particlesPerSecond / Float(particles.count)
        }

        emitterCells = particles.map { particle in
            let cell = CAEmitterCell()

            cell.birthRate = birthRate
            cell.lifetime = 8.0
            cell.velocity = CGFloat(50 * cell.lifetime)
            cell.velocityRange = cell.velocity / 2
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spinRange = .pi * 6
            cell.scaleRange = 0.25
            cell.scale = 0.5 - cell.scaleRange
            cell.contents = particle.image.cgImage
            if let color = particle.color {
                cell.color = color.cgColor
            }

            cell.beginTime = CACurrentMediaTime()

            return cell
        }
    }

    override func layoutSublayers() {
        super.layoutSublayers()

        emitterShape = .line
        emitterSize = CGSize(width: frame.size.width * 0.8, height: 1.0)
        emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
    }
}
