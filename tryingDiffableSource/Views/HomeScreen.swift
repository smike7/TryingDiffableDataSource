//
//  ViewController.swift
//  tryingDiffableSource
//
//  Created by Faisal on 17/02/2023.
//

import UIKit

class HomeScreen: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: <#T##UICollectionViewLayout#>)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func configureCompositionalLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(<#T##fractionalWidth: CGFloat##CGFloat#>), heightDimension: <#T##NSCollectionLayoutDimension#>)
    }
}

