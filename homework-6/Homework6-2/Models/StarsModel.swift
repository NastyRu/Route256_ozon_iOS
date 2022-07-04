//
//  StarsModel.swift
//  Homework6-2
//
//  Created by Анастасия Сиденко on 05.07.2022.
//

import SwiftUI

struct StarsModel: Identifiable {
    var id = UUID()
    let position: CGPoint
    let color: UIColor
    let size: CGFloat
}
