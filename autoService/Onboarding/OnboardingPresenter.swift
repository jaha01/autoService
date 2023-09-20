//
//  OnboardingPresenter.swift
//  autoService
//
//  Created by Yaroslav Magin on 20.09.2023.
//

import Foundation

final class OnboardingPresenter {
    weak var viewController: OnboardingViewController!
    
    func prepareToShowOnboardingData(_ items: [OnboardingInfo]) {
        // mapping, etc...
        viewController.showOnboarding(items)
    }
}
