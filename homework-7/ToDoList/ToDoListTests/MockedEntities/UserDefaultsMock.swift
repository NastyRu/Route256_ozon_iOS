//
//  UserDefaultsMock.swift
//  ToDoListTests
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import Foundation
@testable import ToDoList

class UserDefaultsMock: UserDefaultsProtocol {
    var data: Data?
}
