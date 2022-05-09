//
//  PhotoDetailView.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class PhotoDetailView: UIScrollView {
    
    lazy var id = String()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    
    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.backgroundColor = .black
        photo.contentMode = .scaleToFill
        photo.roundCornersWithRadius(30, top: true, bottom: true, shadowLayer: false)
        photo.clipsToBounds = true
        return photo
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "Name"
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "Date"
        return label
    }()
    
    lazy var downloadsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "Downloads"
        return label
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "mappin"), for: .normal)
        button.backgroundColor = .systemGray6
        button.alpha = 0.8
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var addToFavoriteButton: CustomButton = {
        let button = CustomButton()
        button.toAutoLayout()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular, scale: .default)
        let largeBoldDoc = UIImage(systemName: "star", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .systemYellow
        button.backgroundColor = .white
        button.roundCornersWithRadius(30, shadowLayer: true)
        return button
    }()
    
    lazy var dissmissButton: CustomButton = {
        let button = CustomButton()
        button.toAutoLayout()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .systemGray6
        button.alpha = 0.8
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(downloadsLabel)
        return stackView
    }()
    
    lazy var layerView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .systemGray6
        view.roundCornersWithRadius(30, shadowLayer: true)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(id: String, url: URL, name: String, date: String, downloads: Int, width: Int, height: Int) {

        nameLabel.text = "\(name)"
        
        var dateToFormat = date
        let range = dateToFormat.index(dateToFormat.startIndex, offsetBy: 10)..<dateToFormat.endIndex
        dateToFormat.removeSubrange(range)
        dateLabel.text = "Date: \(dateToFormat)"
        
        downloadsLabel.text = "Downloads: \(String(downloads))"
        photo.sd_setImage(with: url, completed: nil)
        
        setUpConstraints(width: CGFloat(width), height: CGFloat(height))
    }
    
    func setUpFavoriteView(photo: UIImage, name: String, date: String, downloads: String, width: CGFloat, height: CGFloat) {

        nameLabel.text = "\(name)"
        dateLabel.text = "\(date)"
        downloadsLabel.text = "\(downloads)"
        self.photo.image = photo
        
        setUpConstraints(width: width, height: height)
    }
    
    private func setUpConstraints(width: CGFloat, height: CGFloat) {
        addSubview(contentView)
        
        contentView.addSubviews(photo, layerView, labelStackView, dissmissButton, locationButton, addToFavoriteButton)
        
        let height = getImageSize(width: width, height: height)
        
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            photo.heightAnchor.constraint(equalToConstant: height),
            
            layerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            layerView.topAnchor.constraint(equalTo: photo.bottomAnchor),
            layerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            layerView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 16),

            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelStackView.topAnchor.constraint(equalTo: layerView.topAnchor, constant: 16),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            dissmissButton.topAnchor.constraint(equalTo: photo.topAnchor, constant: 24),
            dissmissButton.trailingAnchor.constraint(equalTo: photo.trailingAnchor, constant: -24),
            dissmissButton.widthAnchor.constraint(equalToConstant: 40),
            dissmissButton.heightAnchor.constraint(equalTo: dissmissButton.widthAnchor),

            locationButton.leadingAnchor.constraint(equalTo: photo.leadingAnchor, constant: 24),
            locationButton.topAnchor.constraint(equalTo: photo.topAnchor, constant: 24),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),

            addToFavoriteButton.topAnchor.constraint(equalTo: layerView.topAnchor, constant: 16),
            addToFavoriteButton.trailingAnchor.constraint(equalTo: layerView.trailingAnchor, constant: -16),
            addToFavoriteButton.bottomAnchor.constraint(equalTo: layerView.bottomAnchor, constant: -16),
            addToFavoriteButton.widthAnchor.constraint(equalTo: addToFavoriteButton.heightAnchor),
        ])
    }
    
    private func getImageSize(width: CGFloat, height: CGFloat) -> CGFloat {
        
        if height == 0 {
            return UIScreen.main.bounds.width
        } else {
            let myImageWidth = width
            let myImageHeight = height
            let myViewWidth = UIScreen.main.bounds.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return scaledHeight
        }
    }
}
