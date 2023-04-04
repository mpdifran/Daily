//
//  Particle.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-03.
//

import UIKit

// MARK: - Particle

enum Particle {
    enum Shape {
        case circle
    }

    case shape(Shape, UIColor?)
    case image(UIImage, UIColor?)
}

extension Particle {

    var color: UIColor? {
        switch self {
        case let .image(_, color?),
             let .shape(_, color?):
            return color
        default:
            return nil
        }
    }

    var image: UIImage {
        switch self {
        case let .image(image, _):
            return image
        case let .shape(shape, color):
            return shape.image(with: color ?? .white)
        }
    }
}

private extension Particle.Shape {

    func path(in rect: CGRect) -> CGPath {
        switch self {
        case .circle:
            return CGPath(ellipseIn: rect, transform: nil)
        }
    }

    func image(with color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 12.0, height: 12.0))
        return UIGraphicsImageRenderer(size: rect.size).image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.addPath(path(in: rect))
            context.cgContext.fillPath()
        }
    }
}
