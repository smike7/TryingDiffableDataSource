//
//  ConfigurableCollectionViewCell.swift
//  tryingDiffableSource
//
//  Created by Faisal on 17/02/2023.
//

import UIKit

protocol ConfigurableCollectionViewCell where Self: UICollectionViewCell{
    func setData(using model: some UnsplashModel)
    static var id: String {get}
}
