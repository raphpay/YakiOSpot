//
//  StorageService.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 02/01/2022.
//

import Foundation
import FirebaseStorage

final class StorageService {
    static let shared = StorageService()
    
    private let STORAGE_REF = Storage.storage().reference()
    private lazy var SPOT_REF = STORAGE_REF.child("spot/cornillon") // The folder where the users profile image should be stored
    private lazy var TEST_REF = STORAGE_REF.child("spot/test") // The folder where the users profile image should be stored
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
