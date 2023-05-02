//
//  CustomButton.swift
//  CrocodileChallenge
//
//  Created by Луиза Самойленко on 17.04.2023.
//

import UIKit

class CustomButton: UIButton {
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = color
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        setTitleColor(.white, for: .normal)
        contentMode = .center
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
