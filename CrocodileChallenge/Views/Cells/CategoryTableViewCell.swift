//
//  CategoryTableViewCell.swift
//  CrocodileChallenge
//
//  Created by Marat Guseynov on 19.04.2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryTableViewCell"
    
    // MARK: - Subviews
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var avatarIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var checkMarkImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "check")
        return image
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension

private extension CategoryTableViewCell {
    
    func setupCell() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        checkMarkImage.isHidden = true
        
        addSubview(containerView)
        containerView.addSubview(avatarIcon)
        containerView.addSubview(cellLabel)
        containerView.addSubview(checkMarkImage)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            avatarIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            avatarIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17),
            avatarIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            avatarIcon.widthAnchor.constraint(equalToConstant: 56),
            
            cellLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 37),
            cellLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -37),
            cellLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            checkMarkImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkMarkImage.heightAnchor.constraint(equalToConstant: 30),
            checkMarkImage.widthAnchor.constraint(equalToConstant: 30),
            checkMarkImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Internal Extension

extension CategoryTableViewCell {
    func setupCell(_ category: Category, check: Bool) {
        avatarIcon.image = UIImage(named: category.avatar)!
        containerView.backgroundColor = UIColor(named: category.color)!
        cellLabel.text = category.title
        checkMarkImage.isHidden = !check
    }
}
