//
//  CustomButton.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 01.05.2022.
//

import UIKit

final class CustomButton: UIButton {
    
    var tapButton: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        tapButton?()
    }
}
