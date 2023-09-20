//
//  NewOnboardingViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.09.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Private properties
    //private currentIndexPath: Int()
    private var currentIndexPath: IndexPath?
    private var window: UIWindow?
    private var scene: UIScene?
    
    private let onboardingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Public methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        onboardingCollection.dataSource = self
        onboardingCollection.delegate = self
        setupConstraints()
    }
    
    // MARK: - Private methods
    private func setupConstraints() {
        view.addSubview(onboardingCollection)
        
        NSLayoutConstraint.activate([
            onboardingCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            onboardingCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            onboardingCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            onboardingCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
// MARK: - UICollectionViewDataSource implementation
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(onboardingDetails[indexPath.row])
        cell.delegate = self
        currentIndexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OnboardingViewController: OnboardingCollcetionViewCellDelegate {
    
    
    func onButtonClick() {
        
        guard let currentIndexPath = currentIndexPath else { return }
        
        let indexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
        if indexPath.row < 3 {
            // fixes scrollToItem issue: ...link to StackOverflow/AppleDeveloper
            onboardingCollection.isPagingEnabled = false
            onboardingCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            onboardingCollection.isPagingEnabled = true
        } else {
                DI.shared.authService.setIsNotNewUser()
                
                let window = UIApplication.shared.windows.last { $0.isKeyWindow }
                window?.rootViewController = AuthViewController()
            }
        
        
        // TODO: VIP...
        //
        
    }
    
}