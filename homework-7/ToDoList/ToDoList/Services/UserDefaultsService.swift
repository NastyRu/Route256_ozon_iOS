//
//  UserDefaultsService.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import Foundation

class UserDefaultsService {
    let key: String
    
    init(key: String) {
        self.key = key
    }
}

extension UserDefaultsService: UserDefaultsProtocol {
    var data: Data? {
        get {
            return UserDefaults.standard.data(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
