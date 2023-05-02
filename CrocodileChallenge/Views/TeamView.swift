//
//  TeamView.swift
//  CrocodileChallenge
//
//  Created by VASILY IKONNIKOV on 18.04.2023.
//

import UIKit

class TeamView: UIView {
    
    // MARK: - Subviews
		
	private lazy var avatarImageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	private lazy var teamNameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20)
		label.numberOfLines = 0
		return label
	}()
	
	private lazy var numberOfPointsLabel: UILabel = {
		let label = UILabel()
		label.text = "1"
		label.font = UIFont(name: "Arial Rounded MT Bold", size: 55)
		label.minimumScaleFactor = 0.5
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		return label
	}()
	
	private lazy var captionPointsLabel: UILabel = {
		let label = UILabel()
		label.text = "Очки"
		label.font = UIFont.systemFont(ofSize: 15)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var teamStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.distribution = .fill
		stackView.spacing = 34
		return stackView
	}()
	
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.spacing = 5
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private lazy var pointsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 0
		return stackView
	}()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension

private extension TeamView {
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(teamStackView)
        stackView.addArrangedSubview(pointsStackView)
        teamStackView.addArrangedSubview(avatarImageView)
        teamStackView.addArrangedSubview(teamNameLabel)
        pointsStackView.addArrangedSubview(numberOfPointsLabel)
        pointsStackView.addArrangedSubview(captionPointsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            avatarImageView.heightAnchor.constraint(equalToConstant: 56),
            avatarImageView.widthAnchor.constraint(equalToConstant: 56),
			
			teamNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 10
    }
}

// MARK: - Internal extension

extension TeamView {
    func setTeamName(_ name: String) {
        teamNameLabel.text = name
    }
	
	func setNumberOfPoints(_ point: String) {
		numberOfPointsLabel.text = point
	}
	
	func setAvatar(_ avatar: String) {
		avatarImageView.image = UIImage(named: avatar)
	}
}
