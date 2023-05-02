//
//  WrongViewController.swift
//  CrocodileChallenge
//
//  Created by Владислав Резник on 17.04.2023.
//

import UIKit

class WrongViewController: UIViewController {

	// MARK: - Subviews
	
	private lazy var backgroundImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: Resources.Images.background)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()
	
	private lazy var passButton: CustomButton = {
		let button = CustomButton(title: "Передать ход", color: UIColor(named: Resources.Colors.green)!)
        button.addTarget(self, action: #selector(pass), for: .touchUpInside)
		return button
	}()
	
	private lazy var teamView: TeamView = {
		let view = TeamView()
		return view
	}()
	
	private lazy var resultView: ResultView = {
		let view = ResultView(
			title: "УВЫ И АХ!",
			caption: "Вы не отгадали слово и не получаете очков!",
			pointImage: UIImage(named: Resources.Images.circle)!,
			pointCaption: false,
			numberOfPoints: "0",
			color: UIColor(named: Resources.Colors.red)!
		)
		return view
	}()
	
	// MARK: - Properties
    
    private var manager = GameManager.shared
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		super.viewDidLoad()
		addSubviews()
		setupConstraints()
		
        let currentTeam = manager.getCurrentTeam()
        teamView.setTeamName(currentTeam.name)
        teamView.setAvatar(currentTeam.avatar)
        teamView.setNumberOfPoints("\(currentTeam.score)")
        resultView.nextTeamName(manager.getNextTeam().name)
	}

    
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
        let backButton = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
	}
}

// MARK: - Private extension

extension WrongViewController {
	private func addSubviews() {
		view.addSubview(backgroundImage)
		view.addSubview(teamView)
		view.addSubview(resultView)
		view.addSubview(passButton)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			teamView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			teamView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
			teamView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
			teamView.heightAnchor.constraint(equalToConstant: 96),

			resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
			resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			resultView.heightAnchor.constraint(greaterThanOrEqualToConstant: 301),

			passButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
			passButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
			passButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
			passButton.heightAnchor.constraint(equalToConstant: 60),
		])
	}
	
	private func configureButton() {
		passButton.addTarget(self, action: #selector(pass), for: .touchUpInside)
	}
	
	@objc
	private func pass(_ sender: UIButton) {
        manager.nextMove()
        if manager.getRound() == 0 {
            let vc = GameResultViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
	}
}
