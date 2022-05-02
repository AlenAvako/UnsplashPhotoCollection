//
//  FavoritesTableView.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class FavoritesTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        let plainStyle = UITableView.Style.insetGrouped
        
        super.init(frame: frame, style: plainStyle)
        
        self.register(PreferedTableViewCell.self, forCellReuseIdentifier: PreferedTableViewCell.id)
        
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTableView() {
        self.backgroundColor = .systemYellow
    }
}
