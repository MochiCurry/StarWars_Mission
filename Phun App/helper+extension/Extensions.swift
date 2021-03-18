//
//  Extensions.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/15/21.
//

import Foundation
import UIKit

extension UIImageView {
    func addOverlay(on view: UIView) {
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        overlay.backgroundColor = UIColor.gray
        view.addSubview(overlay)
    }
}

extension UILabel {
    func setupLabel() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.textColor = .white
    }
}

extension UIButton {
    func setupButton(image: UIImage?) {
        self.setImage(image, for: .normal)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 44 / 2
        self.layer.zPosition = 10
    }
}
