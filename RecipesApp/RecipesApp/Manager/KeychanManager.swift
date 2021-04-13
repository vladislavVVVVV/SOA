//
//  KeychanManager.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import KeychainSwift
import UIKit
// This class allows you to work with Keychain using the KeychainSwift library. The main purpose of this class is authorization tokens storage such as an access token and an refresh token. The class is accessed using singleton.
final class KeychainManager {
    static let shared = KeychainManager()
    private let accessKey = "access_token"
    private let ifvKey = "ifv_key"
    private let keychain: KeychainSwift

    private init() {
        keychain = KeychainSwift()
    }
    
    var connectToken: ConnectToken {
        get {
            let accessToken = keychain.get(accessKey) ?? ""
            let ifv = keychain.get(ifvKey) ?? ""
            return ConnectToken(accessToken: accessToken, ifv: ifv)
        }
        set {
            keychain.set(newValue.accessToken, forKey: accessKey)
            let ifv = UIDevice.current.identifierForVendor?.uuidString ?? ""
            keychain.set(ifv, forKey: ifvKey)
        }
    }
    
    func deleteAccountTokens() {
        keychain.delete(accessKey)
    }
}
