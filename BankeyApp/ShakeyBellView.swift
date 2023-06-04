//
//  ShakeyBellView.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 3.06.2023.
//

import Foundation
import UIKit

class ShakeyBellView: UIView {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        setup() // to be tapable
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
    func style(){
        addSubview(imageView)
        // bell
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
    }
    func layout() {
        // bell
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    func setup(){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
    }
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer){
        
    }
    
}
