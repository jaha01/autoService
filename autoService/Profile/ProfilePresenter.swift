//
//  ProfilePresenter.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import UIKit

final class ProfilePresenter {
    
    weak var viewController: ProfileViewController!
    
    func showError(config: AlertConfig) {
        viewController.showErrorAlert(config: config)
    }
    
    func prepareToShowProfileData(_ items: [ProfileInfo]) {
        viewController.pushProfileData(items: items)
    }
}

private let ProfileDetails = [
    ProfileInfo.init(section: "Owner Info", item: [
        Object.init(name: "", placeholder: "1"),
        Object.init(name: "", placeholder: "2"),
        Object.init(name: "", placeholder: "3")
    ]),
    ProfileInfo.init(section: "Car Info", item: [
        Object.init(name: "", placeholder: "4"),
        Object.init(name: "", placeholder: "5"),
        Object.init(name: "", placeholder: "6")
    ])
]
