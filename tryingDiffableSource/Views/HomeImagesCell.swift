//
//  HomeImagesCell.swift
//  tryingDiffableSource
//
//  Created by Faisal on 17/02/2023.
//

import UIKit

class HomeImagesCell: UICollectionViewCell, ConfigurableCollectionViewCell {
    static let id: String = String(describing: HomeImagesCell.self)
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 23
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false 
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("Storyboard sucks...")
    }
    func setData(using model: some UnsplashModel) {
        image.image = UIImage(named: model.name)
    }
    private func setLayout() {
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
