//
//  ViewController.swift
//  tryingDiffableSource
//
//  Created by Faisal on 17/02/2023.
//

import UIKit
private enum Layouts: String {
    case small = "حجم صغير"; case medium = "حجم وسط"; case large = "حجم كبير";
}
private extension UISegmentedControl{
    var selectedLayout: Layouts {
        switch self.selectedSegmentIndex {
        case 0: return Layouts.small
        case 1: return Layouts.medium
        case 2: return Layouts.large
        default: return Layouts.small
        }
    }
}
final class HomeScreen: UIViewController {
    private var data = Image.mockData
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configureMediumCompositionalLayout())
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundColor = .secondarySystemBackground
        cv.register(HomeImagesCell.self, forCellWithReuseIdentifier: HomeImagesCell.id)
        return cv
    }()
    private lazy var layoutChanger: UISegmentedControl = {
        let lc = UISegmentedControl(items: [Layouts.small.rawValue, Layouts.medium.rawValue, Layouts.large.rawValue])
        lc.addTarget(self, action: #selector(shouldUpdateLayout(_:)), for: .valueChanged)
        return lc
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Int, Image>?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setCollectionViewDataSource()
        layoutChanger.selectedSegmentIndex = 1
        reloadData()
    }
    private func setupLayout() {
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(shuffleTapped))
        navigationItem.titleView = layoutChanger
    }
    private func configureCell<Cell: ConfigurableCollectionViewCell>(_ reusableCell: Cell.Type, _ model: some UnsplashModel, using indexPath: IndexPath) -> Cell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell.id, for: indexPath) as? Cell else {fatalError("This should never happen.")}
        cell.setData(using: model)
        return cell
    }
    private func setCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] _, indexPath, itemIdentifier in
            guard let self = self else {return UICollectionViewCell()}
            return self.configureCell(HomeImagesCell.self, itemIdentifier, using: indexPath)
        })
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Image>()
        snapshot.appendSections([1])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    @objc private func shuffleTapped() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Image>()
        snapshot.appendSections([1])
        data = data.shuffled()
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    @objc private func shouldUpdateLayout(_ value: UISegmentedControl) {
        switch value.selectedLayout {
        case .small:
            collectionView.setCollectionViewLayout(configureSmallCompositionalLayout(), animated: true)
        case .medium:
            collectionView.setCollectionViewLayout(configureMediumCompositionalLayout(), animated: true)
        case .large:
            collectionView.setCollectionViewLayout(configureLargeCompositionalLayout(), animated: true)
        }
        collectionView.setContentOffset(.init(x: 0, y: -topbarHeight), animated: false)
    }
}

// MARK: - Layouts
private extension HomeScreen {
    private func configureMediumCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 8, bottom: 8, trailing: 8)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    private func configureSmallCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 8, bottom: 8, trailing: 8)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    private func configureLargeCompositionalLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 8, bottom: 8, trailing: 8)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

