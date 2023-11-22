//
//  OnboardingCollectionViewCell.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.09.2023.
//

import UIKit

protocol OnboardingCollcetionViewCellDelegate: AnyObject {
    func onButtonClick()
}


final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    weak var delegate: OnboardingCollcetionViewCellDelegate?
    
    // MARK: - Private properties
    
    private let welcomeImages: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.text = "HELLO"
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(welcomeImages)
        addSubview(nextButton)
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(_ data: OnboardingInfo) {
        welcomeImages.image = UIImage(named: data.imageName)
        nextButton.setTitle("\(data.buttonName)", for: .normal)
    }
    
    // MARK: - Private methods
    
    @objc private func nextBtnClicked() {
        delegate?.onButtonClick()
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            welcomeImages.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            welcomeImages.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            welcomeImages.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            welcomeImages.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -180),
            
            nextButton.topAnchor.constraint(equalTo: welcomeImages.bottomAnchor, constant: 50),
            nextButton.trailingAnchor.constraint(equalTo: welcomeImages.trailingAnchor, constant: -50),
            nextButton.leadingAnchor.constraint(equalTo: welcomeImages.leadingAnchor, constant: 50),
            nextButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 50)
        ])
    }
}
