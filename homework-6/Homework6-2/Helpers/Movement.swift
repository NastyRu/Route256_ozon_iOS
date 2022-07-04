//
//  Movement.swift
//  Homework6-2
//
//  Created by Анастасия Сиденко on 05.07.2022.
//

import SwiftUI

struct Movement: ViewModifier {
    @State var dx = 0
    @State var dy = 0
    
    func body(content: Content) -> some View {
        content
            .offset(
                x: CGFloat(dx),
                y: CGFloat(dy)
            )
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 1)
                let repeated = baseAnimation.repeatForever(autoreverses: true)

                withAnimation(repeated) {
                    dx = Int.random(in: -50...50)
                    dy = Int.random(in: -50...50)
                }
            }
    }
}

extension View {
    func moving() -> some View {
        modifier(Movement())
    }
}
