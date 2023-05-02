//
//  RoolsViewContoller.swift
//  CrocodileChallenge
//
//  Created by Владислав Резник on 17.04.2023.
//

import UIKit

class RoolsViewContoller: UIViewController {
    // MARK: - Subviews
    
    private lazy var rulesScrollView: UIScrollView = {
        let rulesScrollView = UIScrollView()
        rulesScrollView.translatesAutoresizingMaskIntoConstraints = false
        return rulesScrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rulesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: Resources.Images.background))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        rulesLabel.text = Rules.getRules()
        navigationController?.isNavigationBarHidden = false
    }
}
    // MARK: - Private Extension

    private extension RoolsViewContoller {
        
         func addSubviews() {
             view.addSubview(backgroundImage)
             view.addSubview(rulesScrollView)
             rulesScrollView.addSubview(contentView)
             contentView.addSubview(rulesLabel)
             
             setupConstraints()
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                rulesScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                rulesScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                rulesScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                rulesScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: rulesScrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: rulesScrollView.leadingAnchor),
                contentView.bottomAnchor.constraint(equalTo: rulesScrollView.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: rulesScrollView.leadingAnchor),
                contentView.widthAnchor.constraint(equalTo: rulesScrollView.widthAnchor),

                rulesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                rulesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
                rulesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
                rulesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
            ])
        }
        
    }

