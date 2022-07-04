//
//  Shimmer.swift
//  Homework6-2
//
//  Created by Анастасия Сиденко on 05.07.2022.
//

import SwiftUI

public struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = 0
    var duration = 1.5
    var bounce = true

    public func body(content: Content) -> some View {
        content
            .modifier(AnimatedMask(phase: phase).animation(
                Animation.linear(duration: duration)
                    .repeatForever(autoreverses: bounce)
            ))
            .onAppear { phase = 0.8 }
    }

    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat = 0
        let centerColor = Color.black
        let edgeColor = Color.black.opacity(0.3)

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(LinearGradient(
                    gradient: Gradient(
                        stops: [
                            .init(color: edgeColor, location: phase),
                            .init(color: centerColor, location: phase + 0.1),
                            .init(color: edgeColor, location: phase + 0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                        .scaleEffect(3)
                )
        }
    }
}

public extension View {
    @ViewBuilder func shimmering() -> some View {
        modifier(Shimmer())
    }
}
