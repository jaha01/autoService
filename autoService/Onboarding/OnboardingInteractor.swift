//
//  OnboardingInteractor.swift
//  autoService
//
//  Created by Yaroslav Magin on 20.09.2023.
//

import Foundation

protocol OnboardingInteractorProtocol {
    func onViewDidLoad()
    func onOnboardingCompleted()
}

final class OnboardingInteractor: OnboardingInteractorProtocol {
    // MARK: - Public properties
    
    var router: OnboardingRouterProtocol!
    var presenter: OnboardingPresenterProtocol!
    
    // MARK: - Private properties
    
    private let authService: AuthServiceProtocol
    private let setupService: SetupServiceProtocol
    
    init(authService: AuthServiceProtocol,
         setupService: SetupServiceProtocol) {
        self.authService = authService
        self.setupService = setupService
    }
    
    // MARK: - Public methods
    
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
    
    // MARK: - Private methods
    
    private let onboardingDetails = [
        OnboardingInfo.init(imageName: "welcome_1", buttonName: "Next"),
        OnboardingInfo.init(imageName: "welcome_2", buttonName: "Next"),
        OnboardingInfo.init(imageName: "welcome_3", buttonName: "Done")
    ]
}
