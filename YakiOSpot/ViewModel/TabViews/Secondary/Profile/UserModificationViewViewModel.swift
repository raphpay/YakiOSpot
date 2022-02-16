//
//  UserModificationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 16/02/2022.
//

import Foundation
import UIKit

final class UserModificationViewViewModel: ObservableObject {
    // MARK: - Properties
    @Published var showSheet = false
    @Published var selection: UIImagePickerController.SourceType = .camera
    @Published var hasModifiedImage = false
    @Published var image: UIImage = UIImage(named: Assets.imagePlaceholder)!
    @Published var shouldPresentDialog = false
}
