//
//  APISecurity.swift
//  SIGAI-v3
//
//  Created by Ainal syazwan Itamta on 19/03/2025.
//

import Security
import Foundation

class APISecurity {
    
    private static let serviceIdentifier = Bundle.main.bundleIdentifier! + ".SIGAI.apikey"
    
    /// Saves API Key securely in Keychain
    static func saveAPIKey(_ apiKey: String) {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecValueData as String: apiKey.data(using: .utf8)!
        ]
        
        // Delete old key if exists to avoid duplicates
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add new key
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        if status != errSecSuccess {
            print("Failed to store API Key in Keychain")
        }
    }
    
    /// Retrieves API Key from Keychain
    static func getAPIKey() -> String? {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceIdentifier,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            } else {
                print("Error: Retrieved API key is not in expected format.")
            }
        } else if status == errSecItemNotFound {
            print("Error: API Key not found in Keychain.")
        } else {
            print("Error: Failed to retrieve API Key, status code: \(status)")
        }
        
        return nil
    }
}

// Usage in API Calls
let apiKeychain = APISecurity.getAPIKey() ?? "Error: API Key Not Found"
