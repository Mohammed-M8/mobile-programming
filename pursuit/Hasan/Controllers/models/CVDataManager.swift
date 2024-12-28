//
//  CVDataManager.swift
//  pursuit
//
//  Created by Ali Alqassab on 28/12/2024.
//

import Foundation

class CVDataManager {
    static let shared = CVDataManager()
    private let defaults = UserDefaults.standard
    
    func saveCV(_ cv: CVModel) {
        if let encoded = try? JSONEncoder().encode(cv) {
            defaults.set(encoded, forKey: "savedCV")
        }
    }
    
    func loadCV() -> CVModel? {
        if let savedCV = defaults.object(forKey: "savedCV") as? Data {
            return try? JSONDecoder().decode(CVModel.self, from: savedCV)
        }
        return nil
    }
    
    func removeCV() {
        defaults.removeObject(forKey: "savedCV")
    }
}
