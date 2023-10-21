//
//  OnboardingInteractor.swift
//  autoService
//
//  Created by Yaroslav Magin on 20.09.2023.
//

import Foundation

final class OnboardingInteractor {
    var router: OnboardingRouter!
    var presenter: OnboardingPresenter!
    
    private let authService: AuthService
    let setupService = DI.shared.createSetupService()
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    private let onboardingDetails = [
        OnboardingInfo.init(imageName: "welcome_1", buttonName: "Next"),
        OnboardingInfo.init(imageName: "welcome_2", buttonName: "Next"),
        OnboardingInfo.init(imageName: "welcome_3", buttonName: "Done")
    ]
    
    func onViewDidLoad() {
        // business logic on screen startup
        
        // ... async loading of onboarding data
        presenter.prepareToShowOnboardingData(onboardingDetails)
        
    }
    
    func onOnboardingCompleted() {
        authService.setIsNotNewUser()
        
        switch setupService.getEntryScreen() {
        case .auth:
            router.goToLogin()
        case .mainTabBar:
            router.goToMain()
        default: return
        }
        
    }
}
