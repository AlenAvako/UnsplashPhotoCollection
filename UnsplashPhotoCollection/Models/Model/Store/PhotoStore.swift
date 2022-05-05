//
//  PhotoStore.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 03.05.2022.
//

import UIKit
import CoreData
//
//final class PhotoStore {
//    
//    public static let shared: PhotoStore = .init()
//    
//    var photos: [PhotoInfo]?
//    
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    func fetchPhotos() {
//        do {
//            self.photos = try context.fetch(PhotoInfo.fetchRequest())
//            
////            DispatchQueue.main.async {
////                tableView?.reloadData()
////            }
//        }
//        catch {
//            print("Ошибка декодирования сохраненных изображений", error)
//        }
//    }
//    
//    func createPhoto(photo: UIImage, name: String, date: String, downloads: String) -> PhotoInfo {
//        let newPhoto = PhotoInfo(context: self.context)
//        newPhoto.photo = photo
//        newPhoto.name = name
//        newPhoto.date = date
//        newPhoto.dowloads = downloads
//        
//        return newPhoto
//    }
//    
//    func saveData() {
//        do {
//            try self.context.save()
//        } catch {
//            print("Ошибка при сохранении изображения", error)
//        }
//    }
//
//    func deletePhoto(indexPath: IndexPath, tableView: UITableView) {
//        let photoToRemove = photos![indexPath.row]
//        context.delete(photoToRemove)
//
//        saveData()
//        fetchPhotos()
//    }
//}
