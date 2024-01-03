//
//  OnboardingPresenter.swift
//  autoService
//
//  Created by Yaroslav Magin on 20.09.2023.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func prepareToShowOnboardingData(_ items: [OnboardingInfo])
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var viewController: OnboardingViewControllerProtocol!
    
    // MARK: - Public methods
    
    func prepareToShowOnboardingData(_ items: [OnboardingInfo]) {
        // mapping, etc...
        viewController.showOnboarding(items)
    }
}
