//
//  StorageService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 02/01/2022.
//

import Foundation
import FirebaseStorage
import FirebaseUI

final class StorageService {
    static let shared = StorageService()
    
    private let STORAGE_REF = Storage.storage().reference()
    private lazy var SPOT_REF = STORAGE_REF.child("spot/cornillon") // The folder where the users profile image should be stored
    private lazy var TEST_REF = STORAGE_REF.child("spot/test") // The folder where the users profile image should be stored
    private lazy var USERS_REF = STORAGE_REF.child("users") // The folder where the users profile image should be stored
}


// This is not used for the moment, but it could be helpful when multiple spots are added
extension StorageService {
    func getVideoURL(for track: String, onSuccess: @escaping ((_ downloadURL: URL) -> Void), onError: @escaping((_ error: String) -> Void)) {
        SPOT_REF.child("\(track).mp4").downloadURL { url, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let url = url else {
                onError("No corresponding URL")
                return
            }
            onSuccess(url)
        }
    }
}

extension StorageService {
    func uploadImage(_ image: UIImage?, onSuccess: @escaping ((_ downloadURL: URL) -> Void), onError: @escaping ((_ error: String) -> Void)) {
        // Convert to data
        guard let data = convertImageToData(image),
            let user = API.User.CURRENT_USER_OBJECT else {
            onError("Impossible de convertir les données de l'image")
            return
        }


        let childRef = USERS_REF.child("\(user.id)/bike.jpg")

        childRef.putData(data, metadata: nil) { _, _error in
            guard _error == nil else {
                onError(_error!.localizedDescription)
                return
            }

            childRef.downloadURL { _url, _error in
                guard let downloadURL = _url else {
                    onError("Impossible d'envoyer l'image à la base de donnée")
                    return
                }
                
                onSuccess(downloadURL)
            }
        }
    }
    
    func downloadBikeImageForCurrentUser(onSuccess: @escaping ((_ imageData: Data) -> Void), onError: @escaping((_ error: String) -> Void)) {
        guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
        let reference = USERS_REF.child("\(currentUser.id)/bike.jpg")
        let maximumImageSize = Int64(1 * 1024 * 1024)
        reference.getData(maxSize: maximumImageSize) { data, error in
            guard error == nil else {
                onError(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                onError("No data for this image")
                return
            }

            onSuccess(data)
        }
    }
    
    func convertImageToData(_ image: UIImage?) -> Data? {
        guard let image = image,
              let data = image.sd_imageData(as: .JPEG, compressionQuality: 0.4) else { return nil }
        return data
    }
}
