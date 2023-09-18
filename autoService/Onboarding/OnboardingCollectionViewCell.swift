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
    
    //
//    var onButtonClick: (() -> Void)? // 1 variant
    weak var delegate: OnboardingCollcetionViewCellDelegate? // 2 variant
    
    // MARK: - Private properties
    
    private let welcomeImages: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.text = "HELLO"
        button.setTitle("hola", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .red
        addSubview(welcomeImages)
        addSubview(nextButton)
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public methods
    func setup(_ data: OnboardingInfo) {
        print("img = \(data)")
        welcomeImages.image = UIImage(named: data.imageName)
        nextButton.setTitle("\(data.buttonName)", for: .normal)
        
        //        if obData.buttonName.last {
        //            print("LAST button")
        //        }
    }
    
    // MARK: - Private methods
    
    @objc private func nextBtnClicked() {
        print("Button tapped")
        delegate?.onButtonClick()
//        onButtonClick?()
        
        
        // present SetupService
        //        let visibleItems: NSArray = self.obCollectionView.indexPathsForVisibleItems as NSArray
        //          let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        //          let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        //          self.obCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
        //        //nextButton.titleLabel = obDetails[currentItem].buttonName
        //        print("currentItem = \(currentItem)")
        //        print("nextItem = \(nextItem)")
        //        print("my = \(obCollectionView.indexPathsForSelectedItems)")
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
