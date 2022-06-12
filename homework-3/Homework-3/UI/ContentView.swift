//
//  ContentView.swift
//  Homework-3
//
//  Created by Kazakova Nataliya on 01.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(DummyData.data) { viewModel in
                            ListItemView(viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Список для чтения")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
