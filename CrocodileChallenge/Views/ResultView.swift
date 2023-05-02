//
//  ResultView.swift
//  CrocodileChallenge
//
//  Created by VASILY IKONNIKOV on 18.04.2023.
//

import UIKit

class ResultView: UIView {
	
    // MARK: - Subviews
	
	private lazy var pointImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: Resources.Images.star)
		imageView.tintColor = UIColor(named: Resources.Colors.yellow)
		return imageView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Поздравляем"
		label.font = UIFont(name: "Arial Rounded MT Bold", size: 28)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var captionLabel: UILabel = {
		let label = UILabel()
		label.text = "Вы получаете"
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 16)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var nextTeamLabel: UILabel = {
		let label = UILabel()
		label.text = "Следующий ход - \"Стройняшки\""
		label.font = UIFont.systemFont(ofSize: 16)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var resultStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
        stackView.distribution = .equalSpacing
		stackView.spacing = 10
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private lazy var captionPointLabel: UILabel = {
		let label = UILabel()
		label.text = "ОЧКИ"
		label.font = UIFont.systemFont(ofSize: 13)
		label.textAlignment = .center
		label.textColor = UIColor(named: Resources.Colors.yellow)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var pointLabel: UILabel = {
		let label = UILabel()
		label.text = "1"
		label.textColor = .white
		label.font = UIFont(name: "Arial Rounded MT Bold", size: 55)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupConstraints()
    }
	
	init(title: String, caption: String, pointImage: UIImage, pointCaption: Bool, numberOfPoints: String, color: UIColor) {
		super.init(frame: .zero)
		titleLabel.text = title
		captionLabel.text = caption
		pointImageView.image = pointImage
		captionPointLabel.isHidden = !pointCaption
		pointLabel.text = numberOfPoints
		self.backgroundColor = color
		setupView()
		addSubviews()
		setupConstraints()
	}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension

private extension ResultView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            resultStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            resultStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            resultStackView.topAnchor.constraint(equalTo: topAnchor, constant: 43),
            resultStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -46),
            
            captionPointLabel.centerXAnchor.constraint(equalTo: pointImageView.centerXAnchor),
            captionPointLabel.bottomAnchor.constraint(equalTo: pointImageView.bottomAnchor, constant: 5),
            
            pointLabel.centerXAnchor.constraint(equalTo: pointImageView.centerXAnchor),
            pointLabel.centerYAnchor.constraint(equalTo: pointImageView.centerYAnchor),
        ])
    }
    
    func addSubviews() {
        addSubview(resultStackView)
        resultStackView.addArrangedSubview(titleLabel)
        resultStackView.addArrangedSubview(captionLabel)
        resultStackView.addArrangedSubview(pointImageView)
        pointImageView.addSubview(captionPointLabel)
        pointImageView.addSubview(pointLabel)
        resultStackView.addArrangedSubview(nextTeamLabel)
    }
    
    func setupView() {
        //backgroundColor = UIColor(named: Resources.Colors.green)
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Internal Extension

extension ResultView {
    func nextTeamName(_ name: String) {
        nextTeamLabel.text = "Следующий ход - \"\(name)\""
    }
}
