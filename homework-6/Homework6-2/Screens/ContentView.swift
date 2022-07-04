//
//  ContentView.swift
//  Homework6-2
//
//  Created by Andrey Yakovlev on 22.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var points: [StarsModel] = [
        StarsModel(position: CGPoint(x: UIScreen.screenWidth / 2, y: UIScreen.screenHeight / 2), color: .yellow, size: 100)
    ]
    @State var currentStarId: UUID?
    
    private let colorsArray: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        ZStack {
            ForEach(self.points, id: \.id) { point in
                let x = point.id == currentStarId ? UIScreen.screenWidth / 2 : point.position.x
                let y = point.id == currentStarId ? UIScreen.screenHeight / 2 : point.position.y
                StarsView()
                    .foregroundColor(Color(point.color))
                    .position(x: x, y: y)
                    .frame(maxWidth: point.size, maxHeight: point.size)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            currentStarId = point.id
                        }
                    }
            }
        }
        .statusBar(hidden: true)
        .background(Image("starsBackground"))
        .onClickGesture { point in
            points.append(
                StarsModel(position: point, color: colorsArray.randomElement() ?? .yellow, size: CGFloat.random(in: 100..<500))
            )
        }
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
