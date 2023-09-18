//
//  Model.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.09.2023.
//

import Foundation

public struct OnboardingInfo {
    let imageName: String
    let buttonName: String
}


public let onboardingDetails = [
    OnboardingInfo.init(imageName: "welcome_1", buttonName: "Next"),
    OnboardingInfo.init(imageName: "welcome_2", buttonName: "Next"),
    OnboardingInfo.init(imageName: "welcome_3", buttonName: "Done")
]
