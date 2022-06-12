//
//  ListItemView.swift
//  Homework-3
//
//  Created by Kazakova Nataliya on 01.06.2022.
//

import SwiftUI

fileprivate struct Title: View {
    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.headline)
    }
}

fileprivate struct Tags: View {
    private let tags: [Tag]
    private let isSeleced: Bool
    
    init(tags: [Tag], isSelected: Bool) {
        self.tags = tags
        self.isSeleced = isSelected
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(tags, id: \.title) { tag in
                Text(tag.title)
                    .font(.caption)
                    .padding(.top, 8)
                    .foregroundColor(isSeleced ? .white : .black)
            }
            
            Spacer()
        }
    }
}

fileprivate struct Image: View {
    private let image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        AsyncImage(url: URL(string: image)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 80, height: 80)
        .clipShape(Circle())
    }
}

struct ListItemView: View {
    
    private let viewModel: ListItemViewModel
    private let sortedTags: [Tag]
    @State
    private var isSelected: Bool = false
    
    init(viewModel: ListItemViewModel) {
        self.viewModel = viewModel
        self.sortedTags = viewModel.tags.sorted(by: {
            $0.number < $1.number
        })
    }
    
    var body: some View {
        HStack {
            Image(image: viewModel.image)
            VStack(alignment: .leading, spacing: 0) {
                Title(title: viewModel.title)
                Tags(tags: sortedTags, isSelected: isSelected)
            }
        }
        .padding(16)
        .background(isSelected ? .mint.opacity(0.6) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(viewModel: DummyData.data[0])
            .previewLayout(.sizeThatFits)
            .frame(width: 360, height: 100)
    }
}
