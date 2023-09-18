//
//  NewOnboardingViewController.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.09.2023.
//

import UIKit

final class NewOnboardingViewController: UIViewController {
    
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
extension NewOnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(onboardingDetails[indexPath.row])
        //cell.onButonTap = clouser
        cell.delegate = self
        currentIndexPath = indexPath
        print("section = \(indexPath.section)")
        print("row = \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension NewOnboardingViewController: OnboardingCollcetionViewCellDelegate {
    
    func onButtonClick() {
        print("!!! CLICK !!!")
        guard let currentIndexPath = currentIndexPath else { return }
        print("row = \(currentIndexPath.row + 1)")
        let indexPath = IndexPath(row: currentIndexPath.row + 1, section: currentIndexPath.section)
        print("indexPath = \(indexPath.row)")
        onboardingCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // dissmiss
        self.dismiss(animated: true, completion: nil)
        
        // window  rootview... AuthViewController
        if indexPath.row == 3 {
            guard let windowsScene = (scene as? UIWindowScene) else { print("123123123"); return }
        
        let window = UIWindow(windowScene: windowsScene)
        window.rootViewController = AuthViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    // userdefault
        DI.shared.authService.setIsNotNewUser()
        
        
    // VIP...
    //
    
    
    // Д/З GIT осмысленные описания
    
}

}
