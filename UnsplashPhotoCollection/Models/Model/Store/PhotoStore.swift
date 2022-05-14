//
//  PhotoStore.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 03.05.2022.
//

import UIKit
import CoreData

final class PhotoStore {

    public static let shared: PhotoStore = .init()

    var photos: [LikedPhoto]?

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchPhotos() {
        do {
            self.photos = try context.fetch(LikedPhoto.fetchRequest())
        }
        catch {
            print("Ошибка декодирования сохраненных изображений", error.localizedDescription)
        }
    }

    func createPhoto(id: String, photo: Data, name: String) {
        let newPhoto = LikedPhoto(context: self.context)
        newPhoto.id = id
        newPhoto.photo = photo
        newPhoto.name = name

        saveData()
    }
    
    func deletePhoto(id: String) {
        guard let array = PhotoStore.shared.photos else { return }
        
        for (_, value) in array.enumerated() {
            if id == value.id {
                context.delete(value)
            }
        }
        saveData()
        fetchPhotos()
    }
    
    func deletePhotoFromTableView(indexPath: IndexPath) {
        let photoToRemove = photos![indexPath.row]
        context.delete(photoToRemove)
        
        saveData()
        fetchPhotos()
    }

    private func saveData() {
        do {
            try self.context.save()
        } catch {
            print("Ошибка при сохранении", error.localizedDescription)
        }
    }

}
