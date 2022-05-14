//
//  PhotosCollectionViewCell.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit
import SDWebImage

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let id = "PhotosCollectionViewCell"
    
    var unsplashPhoto: Photo! {
        didSet {
            let photoURL = unsplashPhoto.urls["small"]
            guard let imageURL = photoURL, let url = URL(string: imageURL) else { return }
            photo.sd_setImage(with: url, completed: nil)
        }
    }
    
    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 12
        return photo
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(photo)
        contentView.roundCornersWithRadius(12)
        contentView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
