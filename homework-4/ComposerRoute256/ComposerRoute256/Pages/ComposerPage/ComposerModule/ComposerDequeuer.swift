//
//  ComposerDequeuer.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation
import UIKit

class ComposerDequeuer {
    var collectionView: UICollectionView

    var reusableIds: Set<String> = []

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func dequeueReusableCell<CellClass: UICollectionViewCell>(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellClass {
        if reusableIds.contains(identifier) {
            // Или реюз
            return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CellClass
        } else {
            // Или автоматическая регистрация нового Cell
            collectionView.register(CellClass.self, forCellWithReuseIdentifier: identifier)
            reusableIds.insert(identifier)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CellClass
            return cell
        }
    }
}

