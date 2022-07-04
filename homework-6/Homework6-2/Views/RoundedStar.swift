//
//  Star.swift
//  Homework 6-2
//
//  Created by Andrey Yakovlev on 22.06.2022.
//

import SwiftUI

struct RoundedStar: Shape {
    var cornerRadius: CGFloat = 8

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.95 - rc

        var cangle = -18.0

        for i in 1 ... 5 {
            let cc = CGPoint(x: center.x + rn * CGFloat(cos(Angle(degrees: cangle).radians)), y: center.y + rn * CGFloat(sin(Angle(degrees: cangle).radians)))

            let p = CGPoint(x: cc.x + rc * CGFloat(cos(Angle(degrees: cangle - 72).radians)), y: cc.y + rc * CGFloat(sin(Angle(degrees: (cangle - 72)).radians)))

            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }

            path.addArc(center: cc, radius: rc, startAngle: Angle(degrees: cangle - 72), endAngle: Angle(degrees: cangle + 72), clockwise: false)

            cangle += 144
        }

        return path
    }
}

struct Star_Previews: PreviewProvider {
    static var previews: some View {
        RoundedStar()
            .aspectRatio(1.0, contentMode: .fit)
    }
}
