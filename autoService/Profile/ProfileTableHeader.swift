//
//  ProfileTableHeader.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import UIKit

final class ProfileTableHeader: UIView {

    // MARK: - Private properties
    
    var photo: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "welcome_4")
//        photo.layer.cornerRadius = photo.frame.size.width/2 = 0
        image.layer.cornerRadius = 90
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photo)
        setConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            photo.heightAnchor.constraint(equalToConstant: 180),
            photo.widthAnchor.constraint(equalToConstant: 180)
        ])
        
    }
}
