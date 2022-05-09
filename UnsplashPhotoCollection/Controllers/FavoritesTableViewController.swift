//
//  FavoritesTableViewController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

final class FavoritesTableViewController: UIViewController {
    
    private let photoStorage = PhotoStore.shared
    
    private let favoritesTableView = FavoritesTableView()
    
    override func loadView() {
        super.loadView()
        
        view = favoritesTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        reloadTableView()
        setupNavigationBar()
    }
    
    private func reloadTableView() {
        photoStorage.fetchPhotos()
        favoritesTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "FAVORITE"
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    private func setUpTableView() {
        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    @objc func loadList(notification: NSNotification){
        self.favoritesTableView.reloadData()
    }
}

extension FavoritesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = photoStorage.photos?.count else { return 0 }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: PreferedTableViewCell.id, for: indexPath) as! PreferedTableViewCell
        
        cell.name.text = photoStorage.photos?[indexPath.row].name
        
        cell.photo.image = UIImage(data: (photoStorage.photos?[indexPath.row].photo!)!)
        
        return cell
    }
}

extension FavoritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = photoStorage.photos?[indexPath.row] else { return }
        
        let detail = PhotoDetailViewController()
//        detail.openFavoritePhoto(photo: photo)
        navigationController?.present(detail, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            self.photoStorage.deletePhotoFromTableView(indexPath: indexPath)
            self.favoritesTableView.reloadData()
            complete(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
