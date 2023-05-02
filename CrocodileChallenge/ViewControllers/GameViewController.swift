//
//  GameViewController.swift
//  CrocodileChallenge
//
//  Created by Владислав Резник on 17.04.2023.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Subviews

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Resources.Images.background)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var crocodileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Resources.Images.littleCrocodile)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "01:00"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Картошка"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Объясни с помощью жестов"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private lazy var rightButton: CustomButton = {
        let button = CustomButton(title: "Правильно", color: UIColor(named: Resources.Colors.green)!)
        return button
    }()

    private lazy var brokeRulesButton: CustomButton = {
        let button = CustomButton(title: "Нарушил правила", color: UIColor(named: Resources.Colors.red)!)
        return button
    }()


    private lazy var cancelButton: CustomButton = {
        let button = CustomButton(title: "Сбросить", color: UIColor(named: Resources.Colors.gray)!)
        return button
    }()
    
    // MARK: - Properties
    
    private var timer = Timer()
    private var timeForGame = 60
    private var manager = GameManager.shared
    private lazy var words = Words(category: manager.getCurrentCategory()).getWords()
    private lazy var actions = Words(category: manager.getCurrentCategory()).getActions()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        configureButtons()

        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTimer()
        setTitleLabel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
}

// MARK: - Private Extension

extension GameViewController {
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(crocodileImageView)
        backgroundImageView.addSubview(timerLabel)
        backgroundImageView.addSubview(wordLabel)
        backgroundImageView.addSubview(taskLabel)
        buttonsStackView.addArrangedSubview(rightButton)
        buttonsStackView.addArrangedSubview(brokeRulesButton)
        buttonsStackView.addArrangedSubview(cancelButton)
        view.addSubview(buttonsStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            crocodileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            crocodileImageView.heightAnchor.constraint(equalToConstant: 140),
            crocodileImageView.widthAnchor.constraint(equalToConstant: 140),
            crocodileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            timerLabel.topAnchor.constraint(equalTo: crocodileImageView.bottomAnchor, constant: 54),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            wordLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 50),
            wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            taskLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10),
            taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            buttonsStackView.topAnchor.constraint(lessThanOrEqualTo: taskLabel.bottomAnchor, constant: 100),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),

            rightButton.heightAnchor.constraint(equalToConstant: 60),
            brokeRulesButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func configureButtons() {
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        brokeRulesButton.addTarget(self, action: #selector(brokeRulesButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }

    @objc
    private func rightButtonAction() {
        timer.invalidate()
        manager.addScore()
        let vc = CorrectViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    private func brokeRulesButtonAction() {
        timer.invalidate()
        let vc = WrongViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    private func cancelButtonAction() {
        let alert = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить вашу игру и вернуться в главное меню?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("отмена")
        }
        let agreementAction = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            self?.manager.reset()
            self?.timer.invalidate()
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(agreementAction)
        present(alert, animated: true)
    }

    private func createTimer() {
        timerLabel.text = "01:00"
        timeForGame = 60
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    @objc
    private func timerAction() {
        timeForGame -= 1
        let totalTimeforGame = timeStringFor(seconds: timeForGame)
        timerLabel.text = "\(totalTimeforGame)"
        if timeForGame == 0 {
            timer.invalidate()
            let wrongVC = WrongViewController()
            show(wrongVC, sender: self)
        }
    }

    func timeStringFor(seconds : Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour]
        formatter.zeroFormattingBehavior = .pad
        let output = formatter.string(from: TimeInterval(seconds))!
        return seconds < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
    }

    func setTitleLabel() {
        if words.isEmpty {
            let vc = GameResultViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if let index = words.indices.randomElement() {
            wordLabel.text = words.remove(at: index)
        }
        taskLabel.text = actions.randomElement()
    }
}
