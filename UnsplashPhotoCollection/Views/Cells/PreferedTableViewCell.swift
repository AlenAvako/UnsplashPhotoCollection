//
//  PreferedTableViewCell.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class PreferedTableViewCell: UITableViewCell {
    
    static let id = "PreferedTableViewCell"
    
    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 15
        return photo
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        contentView.addSubviews(photo, name)
        
        NSLayoutConstraint.activate([
            photo.heightAnchor.constraint(equalToConstant: 70),
            photo.widthAnchor.constraint(equalToConstant: 70),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            name.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 25),
            name.centerYAnchor.constraint(equalTo: photo.centerYAnchor)
        ])
    }
}
