//
//  FavoritesTableViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    let favoritesTableView = FavoritesTableView()
    
    override func loadView() {
        super.loadView()
        
        view = favoritesTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    private func setUpTableView() {
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

extension FavoritesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: PreferedTableViewCell.id, for: indexPath) as! PreferedTableViewCell
        
        cell.name.text = "AAA"
        cell.photo.image = UIImage(named: "icon")
        
        return cell
    }
}

extension FavoritesTableViewController: UITableViewDelegate {
    
}
