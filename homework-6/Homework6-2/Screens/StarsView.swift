//
//  StarsView.swift
//  Homework 6-2
//
//  Created by Andrey Yakovlev on 22.06.2022.
//

import SwiftUI

struct StarsView: View {
    var body: some View {
        ZStack {
            RoundedStar()
                .aspectRatio(1.0, contentMode: .fit)
                .shimmering()
                .moving()
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
