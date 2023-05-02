//
//  TeamCollectionViewCell.swift
//  CrocodileChallenge
//
//  Created by Marat Guseynov on 18.04.2023.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    static let identifier = "TeamTableViewCell"
    
    // MARK: - Subviews
    
    private lazy var containerView: UIView = {
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
        label.textColor = .black
        return label
    }()
    
	lazy var pointLabel: UILabel = {
			let label = UILabel()
			label.font = UIFont(name: "Arial Rounded MT Bold", size: 55)
			label.minimumScaleFactor = 0.5
			label.adjustsFontSizeToFitWidth = true
			label.textAlignment = .center
			return label
		}()
		
		private lazy var captionPointsLabel: UILabel = {
			let label = UILabel()
			label.font = UIFont.systemFont(ofSize: 15)
			label.textAlignment = .center
			return label
		}()
		
		private lazy var pointsStackView: UIStackView = {
			let stackView = UIStackView()
			stackView.axis = .vertical
			stackView.alignment = .fill
			stackView.distribution = .fillProportionally
			stackView.spacing = 0
			stackView.translatesAutoresizingMaskIntoConstraints = false
			return stackView
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

private extension TeamTableViewCell {
    func setupCell() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.addSubview(avatarIcon)
        containerView.addSubview(cellLabel)
		containerView.addSubview(pointsStackView)
		pointsStackView.addArrangedSubview(pointLabel)
		pointsStackView.addArrangedSubview(captionPointsLabel)
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
	
			pointsStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
			pointsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
			pointsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - Internal Extension

extension TeamTableViewCell {
    func setupCell(team: Team) {
        avatarIcon.image = UIImage(named: team.avatar)!
        cellLabel.text = team.name
    }
	
	func setupCellResult(team: Team) {
		avatarIcon.image = UIImage(named: team.avatar)
		cellLabel.text = team.name
		pointLabel.text = String(team.score)
		captionPointsLabel.text = "Очки"
	}
}
