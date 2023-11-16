//
//  MapInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 12.11.2023.
//

import Foundation

class MapInteractor {
    var presenter: MapPresenter!
    var router: MapRouter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
}
