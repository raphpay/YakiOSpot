//
//  AuthErrors.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/11/2021.
//

import Foundation

enum AuthError {
    // From the project
    case textFieldsEmpty, signIn, userCreation, signOut
    
    // From Firebase
    case invalidEmail
    case networkError
    case userNotFound
    case userDisabled
    case weakPassword
    case wrongPassword
    case emailAlreadyInUse
         
    var description: String {
        switch self {
        case .textFieldsEmpty:
            return "Veuillez remplir tous les champs de texte !"
        case .signIn:
            return "Impossible de vous connecter pour le moment.\nRevenez plus tard !"
        case .signOut:
            return "Impossible de vous déconnecter pour le moment.\nRevenez plus tard !"
        case .userCreation:
            return "Impossible de vous créer un compte pour le moment.\nRevenez plus tard !"
        case .invalidEmail:
            return "Email non conforme"
        case .networkError:
            return "Mauvaise connexion internet"
        case .userNotFound:
            return "Compte utilisateur non trouvé"
        case .userDisabled:
            return "Compte utilisateur désactivé"
        case .weakPassword:
            return "Le mot de passe doit contenir au moins 6 caractères"
        case .wrongPassword:
            return "Mot de passe invalide"
        case .emailAlreadyInUse:
            return "Cette adresse mail est déjà prise !"
        }
    }
}


