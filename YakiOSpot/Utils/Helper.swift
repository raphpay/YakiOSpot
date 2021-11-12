//
//  Helper.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/11/2021.
//

import Foundation
import Firebase

struct Helper {
    static func convertAuthErrorFromFirebase(_ error: Error) -> String {
        var stringError: String = error.localizedDescription
        
        let errorCode = AuthErrorCode(rawValue: error._code)
        switch errorCode {
        case .invalidEmail:
            stringError = AuthError.invalidEmail.description
        case .networkError:
            stringError = AuthError.networkError.description
        case .userNotFound :
            stringError = AuthError.userNotFound.description
        case .userDisabled:
            stringError = AuthError.userDisabled.description
        case .weakPassword:
            stringError = AuthError.weakPassword.description
        case .wrongPassword:
            stringError = AuthError.wrongPassword.description
        case .emailAlreadyInUse:
            stringError = AuthError.emailAlreadyInUse.description
        default:
            break
        }
        
        return stringError
    }
}
