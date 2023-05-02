//
//  GameResultViewController.swift
//  CrocodileChallenge
//
//  Created by Vasili Staratsitarau on 19.04.2023.
//

import UIKit

class GameResultViewController: UIViewController {
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: Resources.Images.background))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var restartButton: CustomButton = {
        let button = CustomButton(title: "Начать сначала", color: UIColor(named: Resources.Colors.green)!)
        button.addTarget(self, action: #selector(restartButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var teams = [Team]()
    private var heightOfCell: CGFloat = 96
    private var spacingBetweenCells: CGFloat = 28
    private var titleText = "Результаты"
    private var manager = GameManager.shared
    
    // MARK: - Lifecycle
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teams = [manager.getCurrentTeam(), manager.getNextTeam()]
        navigationController?.isNavigationBarHidden = false
        setupNavigationBar()
        addViews()
    }
}

// MARK: - Private Extension

private extension GameResultViewController {
    
    func setupNavigationBar() {
        
        let titleView: UIView = {  // Собственный элемент типа UIView
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = titleText
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        titleView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
        ])
        
        navigationItem.titleView = titleView // Устанавливаем свой элемент в качестве заголовка панели навигации
        navigationItem.hidesBackButton = true
    }
    
    func addViews() {
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        view.addSubview(restartButton)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            restartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            restartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            restartButton.heightAnchor.constraint(equalToConstant: 63),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 148),
            tableView.bottomAnchor.constraint(equalTo: restartButton.topAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
    
	func sortedTeam() -> [Team] {
		let sortedTeams = teams.sorted { score1, score2 in
			score1.score > score2.score
		}
		return sortedTeams
	}
	
    @objc func restartButtonPressed(_ sender: UIButton) {
        
        manager.reset()
        
        guard let viewControllers = navigationController?.viewControllers else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        for vc in viewControllers {
            if vc.isKind(of: TeamViewController.self) {
                navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension GameResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as! TeamTableViewCell
		let sortedTeams = sortedTeam()
        cell.setupCellResult(team: sortedTeams[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell + spacingBetweenCells
        
    }
}

// MARK: - UITableViewDelegate

extension GameResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
}
