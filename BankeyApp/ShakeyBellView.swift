//
//  ShakeyBellView.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 3.06.2023.
//

import Foundation
import UIKit

final class ShakeyBellView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        return imageView
    }()
    
    private let buttonView: UIButton = {
        let buttonView = UIButton()
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .systemRed
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonView.setTitle("9", for: .normal)
        buttonView.setTitleColor(.white, for: .normal)
        return buttonView
    }()
    
    private let buttonHeight : CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup() // to be tapable
        layout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}
// ShakeyBell
extension ShakeyBellView {
    
    private func setup() {
        addSubview(imageView)
        addSubview(buttonView)
        
        translatesAutoresizingMaskIntoConstraints = false
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }

    private func layout() {

        // bell imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        //button
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: -9), // 9 point geri çektim trailing'den
            buttonView.widthAnchor.constraint(equalToConstant: 16),
            buttonView.heightAnchor.constraint(equalToConstant: 16)
        ])
        buttonView.layer.cornerRadius = buttonHeight/2

    }

}
// MARK: - Actions
extension ShakeyBellView {
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
    }

    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
          animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
          },
          completion: nil
        )
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
// u can visit this webside to see this uiview extension to change a view’s anchor point without moving it

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it


