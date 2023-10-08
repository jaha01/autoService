//
//  MapInteractor.swift
//  autoService
//
//  Created by Jahongir Anvarov on 08.10.2023.
//

import Foundation

final class MapInteractor {
    var presenter: MapPresenter!
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
}
